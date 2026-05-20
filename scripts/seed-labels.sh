#!/usr/bin/env bash
#
# 사용법: ./seed-labels.sh <owner/repo>
#   예: ./seed-labels.sh wirobotics/wirobotics-mall-back
#
# 동작:
#   - 같은 디렉토리 한 단계 위의 labels.yml 을 읽어서
#     정의된 모든 라벨을 대상 레포에 추가합니다.
#   - labels.yml 이 단일 진실 원천 (SSOT). 이 스크립트는 그것을 적용할 뿐입니다.
#   - 이미 존재하는 라벨은 자동 skip (멱등성).
#   - 어떤 라벨도 삭제하거나 덮어쓰지 않습니다 (--force 미사용).
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
echo ""

create_label() {
  local name="$1"
  local color="$2"
  local desc="$3"

  if gh label create "$name" \
       --color "$color" \
       --description "$desc" \
       -R "$REPO" 2>/dev/null; then
    echo "✅ 생성: $name"
  else
    echo "⏭️  스킵 (이미 존재): $name"
  fi
}

# labels.yml 을 파싱해서 "name|color|description" 줄로 변환
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

echo "$LABELS_LIST" | while IFS='|' read -r name color desc; do
    [ -z "$name" ] && continue
    create_label "$name" "$color" "$desc"
done

echo ""
echo "✨ 완료. 결과 확인: https://github.com/$REPO/labels"
