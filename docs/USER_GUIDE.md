# wirobotics Application 파트 GitHub 운영 가이드

이슈/PR 트래킹과 프로젝트 관리에 대한 종합 가이드입니다.
**Application 파트의 모든 팀원이 참고하는 문서.**

---

## 📋 목차

1. [전체 그림](#-전체-그림)
2. [자산 구조](#-자산-구조)
3. [Issue Types (5종)](#-issue-types-5종)
4. [Issue Templates](#-issue-templates)
5. [Labels 체계](#-labels-체계)
6. [Application Part Board (Project v2)](#-application-part-board-project-v2)
7. [Project 필터 가이드](#-project-필터-가이드)
8. [Epic 과 sub-issue 관리](#-epic-과-sub-issue-관리)
9. [자동화 (Workflows)](#-자동화-workflows)
10. [역할별 작업 흐름](#-역할별-작업-흐름)
11. [운영 규칙 (Convention)](#-운영-규칙-convention)
12. [FAQ & Troubleshooting](#-faq--troubleshooting)

---

## 🧭 전체 그림

이슈는 **4축**으로 분류됩니다. 각 축은 다른 도구로 관리합니다.

| 축 | 도구 | 답하는 질문 | 예시 |
|---|---|---|---|
| **Type** | Org Issue Types | "무엇인가?" | Bug / Feature / Chore / Task / Epic / PR |
| **Part** | Labels (`part:*`) | "어디 영역?" | frontend, backend, app, design, product |
| **Status** | Projects v2 필드 | "지금 어디?" | Backlog → Todo → In Progress → Review → Done |
| **Priority** | Projects v2 필드 | "얼마나 급한가?" | P0 / P1 / P2 / P3 |

→ **Type 은 본질, Label 은 속성, Status/Priority 는 진행상태**. 절대 섞지 마세요.

---

## 🗄️ 자산 구조

### Organization
- **`wirobotics`** (Free plan, 17 seats)
- Default repository permission: write

### 핵심 Repository

| Repo | 역할 |
|---|---|
| **`wirobotics/.github`** | Org 공통 자산 (이슈 템플릿, 라벨 정의, 자동화 워크플로우) |
| **`wirobotics/application-epic`** | Application 파트의 Epic (프로젝트 명세) 저장소 |
| **`wirobotics/server-api`** 외 13개 | 실제 작업이 일어나는 application 파트 repo (`topic:application`) |

### Project v2

| Project | 번호 | 목적 |
|---|---|---|
| **Application Part Board** | #6 | Application 파트 전체 작업 트래킹 |

URL: https://github.com/orgs/wirobotics/projects/6

---

## 🏷️ Issue Types (5종)

Org Settings → Issue Types 에서 정의된 분류:

| Type | 색 | 사용 시점 |
|---|---|---|
| **🐛 Bug** | Red | 의도와 다르게 동작 (운영/QA 발견 결함) |
| **✨ Feature** | Blue | 새 기능 또는 큰 개선 |
| **🧹 Chore** | Yellow | 리팩토링, 의존성 업데이트, 빌드/CI |
| **📋 Task** | Gray | Epic 하위 작업 / 일반 작업 / 분류 애매할 때 fallback |
| **🎯 Epic** | Purple | 신규 프로젝트, 큰 작업 단위 (application-epic 에서만 작성) |
| **📨 PR** | Orange | 프로젝트 요청 (작업 위치 미정 또는 분해 필요) |

→ Type은 issue template 의 `type:` 필드로 자동 부여됨.

---

## 📝 Issue Templates

### 위치
- **공통 fallback**: `wirobotics/.github/.github/ISSUE_TEMPLATE/`
- **application-epic 전용**: `wirobotics/application-epic/.github/ISSUE_TEMPLATE/`

### 작업 repo (예: server-api, mall-back 등)에서 New Issue 클릭 시

5개 템플릿 노출:
- 🐛 Bug (버그 신고)
- ✨ Feature (기능 개발)
- 🧹 Chore (내부 작업)
- 📋 Task (일반 작업)
- 📨 PR (프로젝트 요청)

> Epic 은 안 보임 (application-epic 에서만 작성)

### application-epic 에서 New Issue 클릭 시

2개 템플릿 노출:
- 🎯 Epic (프로젝트 명세)
- 📨 PR (프로젝트 요청)

### Blank issue

Org member 는 항상 Blank issue 옵션 보임 (GitHub 동작). 외부 사용자는 안 보임 (`blank_issues_enabled: false`).

---

## 🎨 Labels 체계

### `part:*` 라벨 (역할 분류)

| 라벨 | 색 | 의미 |
|---|---|---|
| `part:frontend` | 🔵 파랑 | 프론트엔드 (웹 UI) |
| `part:backend` | 🟢 초록 | 백엔드 (API/서버) |
| `part:app` | 🟠 주황 | 앱 (네이티브/모바일) |
| `part:design` | 🌸 분홍 | 디자인 (UX/시각) |
| `part:product` | 🟡 노랑 | 제품 기획 (요구사항/PM) |

→ Issue 에 part 라벨을 붙여서 **누가 (어느 파트) 작업할지** 명확히.

### 단일 진실 원천

`wirobotics/.github/labels.yml` 에 정의. 모든 application 파트 repo에 자동 동기화됨.

### 자동 동기화

`labels.yml` 변경 + main에 push → 14개 repo 자동 업데이트 (생성 + 색/설명 변경).
- 삭제는 자동 안 됨 (안전 우선)
- 자세한 동작: [자동화 섹션](#-자동화-workflows)

---

## 📊 Application Part Board (Project v2)

### URL
https://github.com/orgs/wirobotics/projects/6

### Visibility
**Private** — wirobotics member 중 직접 access 부여된 사람만.

### Custom Fields

| 필드 | 옵션 |
|---|---|
| **Status** | Backlog → Todo → In Progress → Review → Done |
| **Priority** | P0 / P1 / P2 / P3 |
| **Iteration** | 2주 단위 스프린트 (Duration: 14 days, Monday 시작) |
| **Estimate** | S / M / L |
| **Type** (자동) | Bug / Feature / Chore / Task / Epic / PR |
| **Parent issue** (자동) | sub-issue 관계 기반 |

### Views

| View | Layout | 용도 |
|---|---|---|
| ⚡ Current Sprint | Board | 현재 스프린트 작업 현황 (Status별 컬럼) |
| 📋 Backlog | Table | 백로그 (P0 먼저) |
| 🎯 By Epic | Table | Epic 단위 진행 추적 |
| 👥 By Part | Board | part 라벨별 분배 |
| 👤 My Work | Table | 본인 할당 미완료 |
| 🗓️ Roadmap | Roadmap | 분기/스프린트 타임라인 |
| 🔥 P0 | Table | 긴급 이슈만 |

### 이슈가 Project에 자동 등록되는 메커니즘

- **자동**: `topic:application` 가진 repo의 모든 이슈가 매시간 sync 됨
- **수동도 가능**: 이슈 사이드바 Projects에서 직접 선택

---

## 🔎 Project 필터 가이드

Application Part Board 에서 원하는 이슈만 보기 위한 필터 활용법.

### 필터 입력 위치

```
Project 화면:
  ┌──────────────────────────────────────────┐
  │ [⚡ Current Sprint] [📋 Backlog] ... [+] │
  │                                            │
  │ 🔍 [필터 입력 박스]                        │ ← 여기에 query 입력
  │                                            │
  │ ... 이슈 목록 ...                          │
  └──────────────────────────────────────────┘
```

→ View 안의 필터 박스. View에 저장하면 영구, 단발성으로 쓰면 그 세션만.

### 기본 syntax

| 형태 | 의미 | 예시 |
|---|---|---|
| `field:value` | exact match | `status:Backlog` |
| `field:!value` | not equal | `status:!Done` |
| `field:val1,val2` | OR (같은 필드 내) | `status:Backlog,Todo` |
| `-field:value` | 제외 | `-label:part:design` |
| `is:state` | 이슈 상태 | `is:open`, `is:closed` |
| `no:field` | 값 없음 | `no:assignee`, `no:iteration` |
| 공백 | AND (다른 필드들) | `status:Todo priority:P0` |

### Status / Priority / Iteration 필터

| 필터 | 의미 |
|---|---|
| `status:Backlog` | Backlog 만 |
| `status:"In Progress"` | 공백 포함 시 따옴표 |
| `status:!Done` | Done 제외 |
| `status:Backlog,Todo` | Backlog 또는 Todo |
| `priority:P0` | P0 만 |
| `priority:P0,P1` | P0 또는 P1 |
| `iteration:@current` | 현재 스프린트 |
| `iteration:@next` | 다음 스프린트 |
| `iteration:@previous` | 이전 스프린트 |
| `no:iteration` | 스프린트 미할당 |

### Repo 필터

| 필터 | 의미 |
|---|---|
| `repo:wirobotics/wirobotics-mall-back` | mall-back 만 |
| `repo:wirobotics/admin-api,wirobotics/server-api` | 둘 중 하나 |
| `-repo:wirobotics/application-epic` | application-epic 제외 |

### Assignee / Author

| 필터 | 의미 |
|---|---|
| `assignee:@me` | 본인 할당 |
| `assignee:snlee89` | 특정 유저 |
| `no:assignee` | 미할당 |
| `author:@me` | 본인이 만든 이슈 |

### Label 필터

| 필터 | 의미 |
|---|---|
| `label:part:backend` | 백엔드 part 라벨 |
| `label:"part:design"` | 콜론 포함 시 따옴표 가능 |
| `label:part:backend,part:frontend` | 둘 중 하나 |
| `-label:part:design` | design 제외 |
| `no:label` | 라벨 없음 |

### **Epic 필터** ⭐ (parent-issue)

가장 많이 쓰는 필터 — 특정 Epic 의 sub-issue 만 보기:

| 필터 | 의미 |
|---|---|
| `parent-issue:wirobotics/application-epic#N` | Epic #N 의 자식 이슈만 |
| `no:parent-issue` | Epic에 안 속한 standalone 이슈 |
| `has:sub-issues` | 자식이 있는 (= Epic일 가능성) |

**Epic 번호 찾는 법:**
```bash
gh issue list -R wirobotics/application-epic --json number,title \
  -q '.[] | "#\(.number) \(.title)"'
```
또는 https://github.com/wirobotics/application-epic/issues 에서 확인.

### Date 필터

| 필터 | 의미 |
|---|---|
| `created:>=2026-01-01` | 2026년 이후 생성 |
| `updated:<2026-04-01` | 4월 전 업데이트 (오래된 것) |
| `closed:>2026-05-01` | 5월 이후 닫힘 |

### Type 필터

| 필터 | 의미 |
|---|---|
| `type:Bug` | Bug 만 |
| `type:Feature,Task` | Feature 또는 Task |
| `is:issue` | 이슈만 (PR 제외) |
| `is:pr` | PR 만 |

### 자주 쓰는 조합 예시

**1. 자사몰 현대화 Epic 의 백엔드 작업만**
```
parent-issue:wirobotics/application-epic#2 label:part:backend
```

**2. 자사몰 현대화 Epic 의 미완료 이슈 (Kanban으로)**
```
parent-issue:wirobotics/application-epic#2 status:!Done
```

**3. 이번 스프린트 P0 미완료**
```
iteration:@current priority:P0 status:!Done
```

**4. 오래된 백엔드 백로그 (1개월 이상)**
```
status:Backlog label:part:backend updated:<2026-04-21
```

**5. 미할당 + Priority 없는 이슈 (트리아지 대기)**
```
no:assignee no:priority
```

**6. 본인 In Progress**
```
assignee:@me status:"In Progress"
```

**7. application-epic 의 모든 Epic 목록**
```
repo:wirobotics/application-epic type:Epic
```

**8. 이번 주에 닫힌 이슈 (회고용)**
```
closed:>=2026-05-14 status:Done
```

**9. 특정 repo + 디자인 미진행**
```
repo:wirobotics/wirobotics-mall-front label:part:design status:!Done
```

**10. Epic 에 안 속한 미완료 이슈 (parent 설정 잊은 것)**
```
no:parent-issue status:!Done
```

### 필터를 View 로 저장 (재사용)

자주 쓰는 필터는 view 로 만들어두면 매번 입력 안 해도 됨:

```
1. Project 화면 좌측 상단 "+ New view"
2. View 이름 입력
3. Layout 선택 (Board / Table / Roadmap)
4. 필터 박스에 query 입력
5. 자동 저장 → 탭으로 영구 보존
```

**예시: "🎯 자사몰 현대화 Epic" view 만들기**
- Layout: **Board**
- Group by: `Status`
- Filter: `parent-issue:wirobotics/application-epic#2`
- → Epic #2 의 모든 sub-issue 가 Status 컬럼 형태로 표시

### Tips

- ✅ **자동완성 활용**: `field:` 까지 타이핑하면 가능한 값이 드롭다운으로 표시됨
- ✅ **여러 필터 = 공백** (AND): `status:Todo priority:P0`
- ✅ **같은 필드 OR = 쉼표**: `status:Backlog,Todo`
- ❌ **다른 필드 OR 는 불가** — 그건 별도 view 만들어야 함
- ✅ **NOT 연산**: `!` (값) 또는 `-` (필드 자체) 사용
- ✅ **헷갈리면 view 로**: 한 번 잘 만들어두면 매번 타이핑 안 해도 됨

### View vs Ad-hoc 필터

| | View 저장 | Ad-hoc (필터 박스에 입력만) |
|---|---|---|
| 지속성 | 영구 | 그 세션만 (페이지 새로고침 X) |
| 다른 사람과 공유 | ✅ (모두에게 보임) | ❌ (본인만) |
| 추천 시점 | 매일/매주 보는 화면 | 일회성 조회 |

---

## 🎯 Epic 과 sub-issue 관리

### Epic 만들기 (PM/리드/기획)

1. `https://github.com/wirobotics/application-epic/issues/new/choose`
2. 🎯 Epic 템플릿 선택
3. 목표/배경/범위/성공기준 작성
4. Submit

### Epic 에 작업 이슈 연결 — 3가지 방법

**방법 1: 이슈 생성 시 Parent 설정 (가장 자연스러움)**
- 작업 repo에서 New Issue (Bug/Feature/Chore/Task)
- 본문 작성 + 우측 사이드바의 **Parent issue** 필드에서 Epic 검색 + 선택
- Submit

**방법 2: 이슈 생성 후 Parent 설정**
- 이미 만든 이슈 페이지 → 우측 사이드바 **Parent issue** → Epic 선택

**방법 3: Epic 에서 "Add sub-issue"**
- application-epic#N (Epic) 페이지 → "Sub-issues" 섹션 → "Add sub-issue"
- 작업 이슈 검색해서 선택 (cross-repo 가능)

> ⚠️ **"Create sub-issue" 누르지 말기** — application-epic 안에 작업 이슈가 생기는 함정.
> 반드시 작업 이슈는 작업 repo에 만들고, "Add sub-issue" 로 연결.

### 이슈 transfer (잘못된 위치 정정)

application-epic 에 실수로 작업 이슈 생긴 경우:
```bash
gh issue transfer <num> wirobotics/<correct-repo> -R wirobotics/application-epic
```
- Type, sub-issue 관계, 본문, 라벨 모두 보존
- 원본 URL은 자동 redirect

---

## 🤖 자동화 (Workflows)

### 1. `Seed Labels` — 라벨 자동 동기화

**위치**: `wirobotics/.github/.github/workflows/seed-labels.yml`

**트리거**:
- `labels.yml`, `seed-labels.sh`, `seed-targets.txt`, `seed-all.sh` 변경 push
- 수동 (workflow_dispatch)

**동작**:
- `seed-targets.txt` 에 명시된 14개 repo에 `labels.yml` 라벨 적용
- `gh label create --force` 사용 — 생성 + 색/설명 업데이트 자동

**관리**:
- 새 application repo 추가 → `seed-targets.txt` 에 추가 + push
- 새 라벨 추가 → `labels.yml` 수정 + push (모든 repo에 자동 적용)
- **삭제는 수동** (안전 원칙)

### 2. `Sync App Project` — 이슈 ↔ Project 자동 등록

**위치**: `wirobotics/.github/.github/workflows/sync-app-project.yml`

**트리거**:
- 매시간 정각: **Incremental** (최근 3시간 변경분만)
- 매주 토요일 18:00 UTC (= 일요일 03:00 KST): **Full sync** (안전망)
- 수동 (workflow_dispatch) — full_sync 옵션 선택 가능

**동작**:
- `topic:application` 가진 모든 repo의 이슈를 Application Part Board 에 등록
- Closed 이슈는 자동으로 Status=Done
- 멱등성 보장 (이미 등록된 항목 skip)

**보장**:
- 새 이슈 생성 → 최대 1시간 lag로 Project에 자동 등록
- 새 application repo 추가 → topic 붙이면 다음 sync 부터 자동 포함

### 3. `_add-to-app-board` (reusable, 미사용 중)

**상태**: 보존되어 있으나 현재 호출 안 됨.

**미사용 이유**: 분산 workflow 방식 (실시간 add)을 위해 만들었으나 Free plan의 org secret 제약으로 private repo 적용 불가. **유료 플랜 (Team+) 업그레이드 후 활성화 가능**.

---

## 👥 역할별 작업 흐름

### PM / 기획자

```
신규 프로젝트:
  1. application-epic 에서 🎯 Epic 작성 (명세)
  2. Epic body에 "백엔드/프론트엔드 작업 필요" 정도만 명시
  3. (선택) 백엔드/프론트엔드 lead에 @멘션
  4. Project #6 의 "🎯 By Epic" view에서 진행 추적

일반 작업 요청:
  - 위치 모름 → application-epic 에 📨 PR 작성, lead가 적절한 repo로 transfer
  - 위치 알면 → 그 repo 에서 직접 ✨ Feature 또는 📋 Task 작성, Parent issue 로 Epic 연결
```

### 개발자

```
1. 본인 일감 확인 → Project #6 의 "👤 My Work" view
2. 새 이슈 자체 생성:
   - 작업 repo 에서 적절한 template (Bug/Feature/Chore/Task)
   - 우측 사이드바: 
     - Parent issue (관련 Epic)
     - Labels: part:* (본인 영역)
     - Assignees: 본인
   - Submit
3. Project 등록: 1시간 이내 자동 (Sync App Project)
4. Status 관리: Project 보드에서 컬럼 드래그 (Todo → In Progress → Done)
```

### Lead / 트리아지 담당

```
주 1회 트리아지:
  1. Project #6 의 "📋 Backlog" view 검토
  2. 새 이슈에 Priority 부여
  3. 적절한 Iteration (스프린트) 할당
  4. Assignee 지정
  5. application-epic 의 PR 이슈 → 적절한 repo로 transfer
```

---

## 📐 운영 규칙 (Convention)

### Issue 생성

- ❌ **Blank issue 사용 자제** — 항상 template 사용
- ❌ **`Create sub-issue` 누르지 말기** — application-epic 에 작업 이슈 생김
- ❌ **Epic 은 application-epic 에서만** — 다른 repo 의 Epic 옵션 비활성화됨
- ✅ **`part:*` 라벨 항상 부여** — 어느 파트 일감인지 명확히
- ✅ **Parent issue 설정** — 관련 Epic 이 있으면 연결

### Project Status 관리

- ✅ **Backlog → Todo → In Progress → Review → Done** 순서로 컬럼 이동
- ✅ **이슈 close 시 자동 Done** — 별도 작업 불필요 (workflow 자동)
- ❌ **Status 건너뛰기 자제** — 흐름 추적 어려워짐

### Label 관리

- ✅ **`labels.yml` 변경은 PR 통해서만** — 모든 repo에 영향
- ❌ **개별 repo에서 라벨 직접 수정 자제** — 다음 sync 때 덮어쓰임
- ✅ **새 application repo 만들면**:
  1. `wirobotics/.github/scripts/seed-targets.txt` 에 repo 이름 추가
  2. PR 머지 → 자동으로 라벨 적용됨
  3. (선택) repo에 `application` topic 부여

---

## ❓ FAQ & Troubleshooting


### Q. 이슈에 Type 이 자동 부여 안 돼요
- Org Issue Types 에 해당 Type 이 있는지 확인
- 템플릿 yml의 `type:` 값과 Org Issue Type 이름 일치하는지 (대소문자 정확히)

### Q. Project 에 이슈가 안 들어와요
- 수동 추가: 이슈 사이드바 Projects → Application Part Board
- 1시간 lag 있음 (다음 hourly sync 기다리기)
- 해당 repo 에 `topic:application` 있는지 확인

### Q. Closed 이슈가 Done 으로 안 됨
- Sync App Project workflow 가 자동 처리 (다음 sync 시점)
- 즉시 처리하려면 수동 트리거: `gh workflow run sync-app-project.yml -R wirobotics/.github`

### Q. 새 라벨 추가했는데 다른 repo에 안 들어옴
- `labels.yml` 수정 후 main에 push 되었는지
- Seed Labels workflow 가 성공했는지 (Actions 탭에서 확인)
- `LABEL_SEED_TOKEN` secret이 만료/회수 안 됐는지

### Q. Epic 의 sub-issue 관계를 cross-repo 로 만들 수 있나요?
- ✅ 네, 같은 org 내라면 자유롭게 가능
- application-epic 의 Epic → 작업 repo 의 이슈를 자식으로

### Q. 이슈를 다른 repo 로 옮기고 싶어요
- `gh issue transfer <num> wirobotics/<target-repo> -R wirobotics/<source-repo>`
- 또는 이슈 페이지 사이드바 "Transfer issue"
- Type, sub-issue 관계, 본문 보존됨

### Q. Workflow 실행 결과를 보고 싶어요
- `https://github.com/wirobotics/.github/actions`
- 또는 `gh run list -R wirobotics/.github`

### Q. 매시간 sync 가 부담스러우면?
- Cron 변경: `.github/workflows/sync-app-project.yml` 의 schedule 수정 (예: `0 */4 * * *` 4시간마다)
- 또는 비활성화: `gh workflow disable sync-app-project.yml -R wirobotics/.github`

---

## 🔗 자주 가는 URL 모음

| 자산 | URL |
|---|---|
| Org 자산 (.github repo) | https://github.com/wirobotics/.github |
| Application 파트 Epic | https://github.com/wirobotics/application-epic |
| Application Part Board | https://github.com/orgs/wirobotics/projects/6 |
| Workflows | https://github.com/wirobotics/.github/actions |
| Org Issue Types | https://github.com/organizations/wirobotics/settings/issue-types |
| Org Secrets | https://github.com/organizations/wirobotics/settings/secrets/actions |

---

