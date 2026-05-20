#!/usr/bin/env bash
#
# 사용법: ./seed-all.sh
#
# scripts/seed-targets.txt 의 모든 레포에 seed-labels.sh 를 일괄 실행.
# 각 레포에 part:* 라벨을 추가합니다 (이미 있으면 skip — 멱등).
#
# 환경 변수:
#   OWNER       기본: wirobotics
#
# 요구사항: gh CLI 인증 (`gh auth login`) 또는 GH_TOKEN/GITHUB_TOKEN 환경변수

set -euo pipefail

OWNER="${OWNER:-wirobotics}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGETS_FILE="$SCRIPT_DIR/seed-targets.txt"
SEED_SCRIPT="$SCRIPT_DIR/seed-labels.sh"

if [ ! -f "$TARGETS_FILE" ]; then
  echo "❌ Targets file not found: $TARGETS_FILE" >&2
  exit 1
fi

if [ ! -x "$SEED_SCRIPT" ]; then
  echo "❌ Seed script not executable: $SEED_SCRIPT" >&2
  exit 1
fi

echo "🌱 라벨 시드 시작 (OWNER=$OWNER)"
echo ""

count=0
failed=0
while IFS= read -r line || [ -n "$line" ]; do
  # Strip comments and whitespace
  trimmed="${line%%#*}"
  trimmed="$(echo "$trimmed" | tr -d '[:space:]')"
  [ -z "$trimmed" ] && continue

  count=$((count + 1))
  echo "═══ [$count] $OWNER/$trimmed ═══"
  if "$SEED_SCRIPT" "$OWNER/$trimmed"; then
    :
  else
    failed=$((failed + 1))
    echo "⚠️  실패: $OWNER/$trimmed"
  fi
  echo ""
done < "$TARGETS_FILE"

echo "✨ 전체 완료 — 처리: $count 개, 실패: $failed 개"
[ "$failed" -eq 0 ]
