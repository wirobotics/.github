#!/usr/bin/env bash
#
# 사용법: ./seed-labels.sh <owner/repo>
#   예: ./seed-labels.sh my-org/my-product
#
# 동작:
#   - labels.yml 에 정의된 라벨을 대상 레포에 추가합니다.
#   - 이미 존재하는 라벨은 에러 메시지 후 skip 됩니다 (기존 자산 보호).
#   - 어떤 라벨도 삭제하거나 덮어쓰지 않습니다.
#
# 요구사항: gh CLI 로그인 (`gh auth login`)

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "사용법: $0 <owner/repo>"
  exit 1
fi

REPO="$1"

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

# ─── part:* ───
create_label "part:frontend" "1D76DB" "프론트엔드 (웹 UI)"
create_label "part:backend"  "0E8A16" "백엔드 (API/서버)"
create_label "part:app"      "D93F0B" "앱 (네이티브/모바일)"
create_label "part:design"   "F9D0C4" "디자인 (UX/시각)"
create_label "part:product"  "FBCA04" "제품 기획 (요구사항/PM)"

echo ""
echo "✨ 완료. 결과 확인: https://github.com/$REPO/labels"
