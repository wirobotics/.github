# .github

이 레포는 **wirobotics** organization 의 GitHub 공통 자산을 관리합니다.

## 무엇이 들어있나요?

| 파일 | 역할 | 적용 방식 |
|---|---|---|
| `ISSUE_TEMPLATE/*.yml` | 이슈 생성 템플릿 | **자동 fallback** — 템플릿 없는 모든 레포에 적용 |
| `labels.yml` | 라벨 정의 (단일 진실 원천) | 문서 — 직접 적용 X |
| `scripts/seed-labels.sh` | 레포에 라벨 추가하는 스크립트 | **수동 실행** — 레포별 1회 |

## 자동 적용되는 것 / 안 되는 것

| 자산 | 자동? |
|---|---|
| Issue Templates | ✅ — 이 레포에 푸시하면 즉시 모든 레포에 fallback |
| Labels | ❌ — 레포마다 `seed-labels.sh` 실행 필요 |
| Org Issue Types | ❌ — Org Settings에서 수동 정의 (Bug/Feature/Chore/Task) |

## 사용 가이드

### 새 레포를 만들었을 때

1. **이슈 템플릿**: 아무것도 안 해도 됨. 이 레포의 템플릿이 자동으로 보입니다.
2. **라벨**: 한 번만 실행:
   ```bash
   gh repo clone wirobotics/.github
   cd .github
   ./scripts/seed-labels.sh wirobotics/<new-repo>
   ```

### 이슈 템플릿 수정/추가하고 싶을 때

1. `ISSUE_TEMPLATE/` 안의 yml 수정 / 새 yml 추가
2. PR 머지 → **즉시 모든 레포에 반영** (별도 sync 불필요)

### 라벨 추가/수정하고 싶을 때

1. `labels.yml` + `scripts/seed-labels.sh` 둘 다 수정
2. PR 머지
3. 적용하고 싶은 레포마다 다시 실행

### 특정 레포에서 다른 템플릿을 쓰고 싶을 때

해당 레포에 `.github/ISSUE_TEMPLATE/` 디렉토리를 만들면 **그 레포만 override** 됩니다.

## 분류 체계

이슈는 4축으로 나뉩니다:

| 축 | 도구 | 답하는 질문 | 예시 |
|---|---|---|---|
| **Type** | Org Issue Types | "무엇인가?" | Bug / Feature / Chore / Task |
| **Part** | Labels (`part:*`) | "어디 영역?" | `part:frontend`, `part:backend`, `part:app`, `part:design`, `part:product` |
| **Status** | Projects v2 필드 | "지금 어디?" | Backlog / Todo / In Progress / Done |
| **Priority** | Projects v2 필드 | "얼마나 급한가?" | P0 / P1 / P2 / P3 |

> **Priority와 Status는 라벨이 아닙니다.** Projects v2 커스텀 필드로 관리합니다.

## 안전 원칙

- 스크립트는 `gh label create` 만 사용 — 기존 라벨 **삭제/덮어쓰기 절대 없음**
- 이미 있는 라벨은 자동 skip (멱등성)
- 자동 sync action 사용하지 않음 — 명시적 실행이 안전

## 의존성

- `gh` CLI ([설치](https://cli.github.com/))
- `gh auth login` 완료

## 관련 작업

- **Org Issue Types 정의** (Bug/Feature/Chore/Task) — Org Settings → Issue Types
- **Projects v2 셋업** — 별도 작업
