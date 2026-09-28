---
name: planning
description: Pick what to work on (a roadmap task, a bug, or a new idea), clear up what is unclear by asking one question at a time, write a step-by-step plan, and implement only after I approve it.
argument-hint: "[M2.3 | B-004 | description of what to build]"
disable-model-invocation: true
---

# Planning

Works from the roadmap (`docs/ROADMAP.md` or root `ROADMAP.md`) and `docs/BUGS.md`. Either may be missing; then plan from the conversation alone.

**Don't edit any file until I approve the plan.**

## 1. Pick the work

- **No arguments**: ask what we work on, as one multiple-choice question:
  - the next 1 to 2 open tasks of the `[in progress]` milestone
  - the top 1 to 2 open bugs by severity
  - "something else", where I describe it
- **An ID** (`M2.3`, `B-004`): load that task or bug.
- **A description**: use it as-is.

If the work is not in the roadmap or bugs, ask whether to add it: as a task in the current milestone, a bug, or leave it untracked.

## 2. Understand before planning

1. Look up what the code can answer yourself: grep, then read only the relevant parts. Use an Explore subagent only for a wide search where only the conclusion matters.
2. Ask me only what the code can't answer.
   - The description is clear: ask 0 to 2 questions, just on the gaps.
   - It's vague: grill me. Ask one question at a time, each with your recommended answer, and go down each branch of the decision until nothing is open.
   - Never ask something the code, the roadmap or an earlier answer already settles.

## 3. Write the plan

Keep it short.

```
Goal: <one sentence, what is true when done>   (M2.3 / B-004)

Steps:
1. <change> in `path/file.ts`: verify: <test/command/what to look at>
2. ...

Risks: <what could break, migrations, data>
Out of scope: <what we deliberately won't do>
```

- For a small change (1 to 3 files), 2 to 4 steps with no Risks section is fine.
- Each step must be verifiable on its own. For a bug, step 1 reproduces it (ideally with a failing test) before any fix.
- Follow the patterns already in the code. No new abstractions without 2 real uses.
- If the work won't fit in one session, split it: plan the first slice, propose the rest as new roadmap tasks.

End with: `Ok?` and stop.

## 4. After I approve

Implement step by step, verifying each step as written. If reality differs from the plan (a wrong assumption, a new file needed), stop and tell me before continuing.

When done, suggest `/zaha:test`, then `/zaha:recap`. Don't commit unless I ask.
