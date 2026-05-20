#!/usr/bin/env bash
#
# 사용법: ./seed-labels.sh <owner/repo>
#   예: ./seed-labels.sh wirobotics/wirobotics-mall-back
#
# 동작:
#   - 같은 디렉토리 한 단계 위의 labels.yml 을 읽어서
#     정의된 모든 라벨을 대상 레포에 적용 (생성 또는 업데이트) 합니다.
#   - labels.yml 이 단일 진실 원천 (SSOT).
#   - 신규 이름 → 생성
#   - 기존 이름 (이미 레포에 있음) → 색깔/설명 업데이트 (`--force` 사용)
#   - 라벨 삭제는 자동화하지 않습니다 (안전 우선, 별도 수동 작업).
#
# 요구사항:
#   - gh CLI 로그인 (`gh auth login`) 또는 GH_TOKEN/GITHUB_TOKEN
#   - python3 + pyyaml (`pip3 install pyyaml`)

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "사용법: $0 <owner/repo>"
  exit 1
fi

REPO="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABELS_YML="${SCRIPT_DIR}/../labels.yml"

if [ ! -f "$LABELS_YML" ]; then
  echo "❌ labels.yml not found at $LABELS_YML" >&2
  exit 1
fi

echo "📍 대상 레포: $REPO"

# 기존 라벨 목록을 한 번에 가져와서 캐싱 (API 호출 절약)
EXISTING_LABELS=" $(gh label list -R "$REPO" --limit 200 --json name -q '.[].name' 2>/dev/null | tr '\n' ' ') "

echo ""

apply_label() {
  local name="$1"
  local color="$2"
  local desc="$3"

  local action
  if [[ "$EXISTING_LABELS" == *" $name "* ]]; then
    action="♻️  업데이트"
  else
    action="✅ 생성    "
  fi

  if gh label create "$name" \
       --color "$color" \
       --description "$desc" \
       --force \
       -R "$REPO" >/dev/null 2>&1; then
    echo "$action: $name"
  else
    echo "⚠️  실패     : $name"
  fi
}

# labels.yml 파싱
LABELS_LIST=$(python3 - "$LABELS_YML" <<'PY'
import sys, yaml
with open(sys.argv[1]) as f:
    data = yaml.safe_load(f) or {}
for category, items in data.items():
    if isinstance(items, list):
        for item in items:
            name = item.get('name', '')
            color = item.get('color', '')
            desc = item.get('description', '')
            if name and color:
                print(f"{name}|{color}|{desc}")
PY
)

# 각 라벨 적용
echo "$LABELS_LIST" | while IFS='|' read -r name color desc; do
    [ -z "$name" ] && continue
    apply_label "$name" "$color" "$desc"
done

echo ""
echo "✨ 완료. 결과 확인: https://github.com/$REPO/labels"
