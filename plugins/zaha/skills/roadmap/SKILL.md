---
name: roadmap
description: Build or show the project roadmap in docs/ROADMAP.md (milestones with checkable tasks). First run scaffolds it from git history, docs and existing STATUS/BACKLOG files; later runs show where the project is and what comes next.
argument-hint: "[change to make, e.g. 'add milestone for payments']"
disable-model-invocation: true
---

# Roadmap

The roadmap lives in `docs/ROADMAP.md`. Sibling files: `docs/BUGS.md` (owned by `/zaha:bug`), `docs/HISTORY.md` (owned by `/zaha:recap`). Task IDs are `M<n>.<k>`, bug IDs `B-<nnn>`; never renumber or reuse an ID.

**First, find an existing roadmap**: `docs/ROADMAP.md`, else `ROADMAP.md` at the root. If one exists, it is the roadmap: never create a second one. Keep its format exactly (layout, language, markers, IDs) instead of the format below; run `grep -rlI ROADMAP --exclude-dir={node_modules,.git}` and if code reads it, check that your edits still match what that code parses.

Pick the mode:

- **No roadmap found** → Scaffold.
- **File exists, no arguments** → Status.
- **File exists, arguments given** → Change.

## Scaffold

1. Gather cheaply, without reading source files wholesale:
   - `README*`, the project `CLAUDE.md`, and any planning docs (`STATUS.md`, `TODO*`, `BACKLOG*`, `docs/*.md`).
   - `git log --oneline | head -80` and `git log --reverse --oneline | head -20`.
   - The top two levels of the file tree.
2. Draft the roadmap:
   - 1 to 4 **done** milestones rebuilt from history. Keep them coarse, with tasks already ticked.
   - 1 **in progress** milestone.
   - 1 to 3 **planned** milestones.
   - Carry over every open item from old planning docs; don't drop any.
3. Show the draft in chat. Ask about what you are unsure of, one question at a time, each with your recommended answer. Write the file only after I say ok.
4. If old planning docs were used, ask whether to delete them, keep them, or replace them with a one-line pointer to `docs/ROADMAP.md`.

## Status

Read the roadmap, plus open bugs in `docs/BUGS.md` if it exists. Reply in at most 8 lines:

```
M2 · Auth: 2/3 done
Next: M2.3 Add password reset, then M3.1 Stripe checkout for one plan
Open bugs on M2: B-004 [high]
Suggested: /zaha:planning M2.3
```

Don't edit the file in this mode.

## Change

Apply the requested change (add, reorder, rename, split, mark done), update the `Updated:` date, and show only the changed lines.

## Format

```markdown
# Roadmap

Current: M2 · Updated: 2026-09-28

## M1 · Project setup [done]
- [x] M1.1 Scaffold Next.js app with auth provider
- [x] M1.2 Deploy to Vercel

## M2 · Auth [in progress]
Goal: users can sign up, log in and reset their password.
- [x] M2.1 Email + password signup
- [x] M2.2 Login with session cookie
- [ ] M2.3 Add password reset (B-004)

## M3 · Payments [planned]
- [ ] M3.1 Stripe checkout for one plan
```

Rules:
- A milestone is a shippable outcome with a one-line `Goal:`.
- A task is one line, starts with a verb, and fits in one session. Split it if it doesn't.
- Link bugs as `(B-004)` on the task they block.
- Mark a task done only with evidence: a commit, a passing test, or my word.
- Exactly one milestone is `[in progress]`.
