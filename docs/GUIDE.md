# Using the `zaha` plugin

A small workflow for working on a project with Claude Code: keep the plan, the bugs and the history in plain Markdown next to your code, and let each session pick up from there.

## Install

In Claude Code:

```
/plugin marketplace add zaha27/skills
/plugin install zaha@zaha-skills
```

Update later with `/plugin marketplace update zaha-skills`, then restart Claude Code.

## Calling the skills

Every skill has a full name, `/zaha:<name>`, which always works. Most also work by their short name:

| Short name works | Full name only |
|---|---|
| `/roadmap`, `/planning`, `/test`, `/handoff`, `/what` | `/zaha:bug`, `/zaha:recap` |

`/bug` and `/recap` are built-in Claude Code commands (`/bug` sends a report to Anthropic), so the short names start those instead.

All skills are user-invoked: Claude never starts them on its own, and they cost no context until you type them.

## The files

Each project gets up to three files. You can read and edit them by hand; the skills follow whatever they find.

| File | Created by | Holds |
|---|---|---|
| `docs/ROADMAP.md` | `/roadmap` | milestones `M1, M2…` with tasks `M2.3` |
| `docs/BUGS.md` | `/zaha:bug` | bugs `B-001…`, open and fixed |
| `docs/HISTORY.md` | `/zaha:recap` | one entry per recap, newest first |

If the project already has a `ROADMAP.md` at the root (or a `BUGS.md` / `HISTORY.md`), the skills use it and keep its format. IDs are never renumbered or reused.

## The loop

```
/roadmap → /planning → (implement) → /test → /zaha:bug → /zaha:recap → /planning …
```

A typical session:

1. `/roadmap`: where are we, what's next?
2. `/planning`: pick the next task, answer a few questions, approve the plan.
3. Claude implements it step by step.
4. `/test`: run the affected tests.
5. `/zaha:bug …` for anything broken you notice along the way.
6. `/zaha:recap`: log what changed and tick finished tasks.
7. `/handoff` then `/clear` if you'll continue later.

## The skills

### `/roadmap`

- **First run** (no roadmap yet): builds a draft from git history, the README and any `STATUS`/`TODO`/`BACKLOG` files, shows it, and writes `docs/ROADMAP.md` only after you say ok.
- **Later, no arguments**: a status of up to 8 lines: current milestone, next tasks, open bugs, suggested next step.
- **With arguments**: changes the roadmap, e.g. `/roadmap add a milestone for payments`, `/roadmap split M2.3`.

### `/planning`

- `/planning`: asks what to work on, offering the next roadmap tasks, the worst open bugs, or "something else".
- `/planning M2.3` or `/planning B-004`: plans that task or bug.
- `/planning add CSV export to the reports page`: plans from your description.

It reads the code first and only asks what the code can't answer: 0 to 2 questions if your description is clear, a one-question-at-a-time interview if it's vague. Then it writes a short plan (goal, steps with how to verify each, risks) and ends with `Ok?`. **Nothing is edited before you approve.** For a bug, step 1 is always reproducing it.

### `/test`

- `/test`: runs only the tests related to the files you changed.
- `/test all`: the full suite.
- `/test auth/session.test.ts`: exactly that file or pattern.

It finds the test command itself (project `CLAUDE.md`, `package.json`, `pytest`, `go`, `cargo`, `Makefile`), filters the output, and reports each failure as caused by your change (offers to fix) or pre-existing (offers `/zaha:bug`). It skips e2e and browser suites unless you ask.

### `/zaha:bug`

- `/zaha:bug login fails on Safari`: logs it with the next ID, a severity (`high`/`med`/`low`) and the milestone it belongs to.
- `/zaha:bug list`: open bugs, worst first.

It checks for duplicates and never fixes anything: you are probably in the middle of something else. Fix it later with `/planning B-007`.

### `/zaha:recap`

- `/zaha:recap`: everything since the last recap.
- `/zaha:recap since monday`: a custom range.

Writes a short entry to `docs/HISTORY.md` (what changed, decisions, what's done, what's next), ticks finished roadmap tasks and moves fixed bugs to "Fixed". It never commits.

### `/handoff`

- `/handoff`: saves the current session state to `~/.claude/handoffs/<repo>.md`.
- `/handoff next: finish the export tests`: tailors it to what the next session will do.

Use it before `/clear`. Start the new session with the line it prints (`Continue from ~/.claude/handoffs/<repo>.md`). `recap` is the project's history; `handoff` is "where exactly did we stop".

### `/what`

Type it when an answer didn't make sense. Claude re-explains its last message in plain words, with context and an example.

## Tips

- **Save tokens**: `/handoff` + `/clear` whenever you switch tasks. A long session re-reads everything on every message.
- **Check what a skill changed**: `git diff`. None of the skills commit.
- **Test command**: add a line like ``Test: `npm test` `` to the project `CLAUDE.md` and `/test` skips detection.
