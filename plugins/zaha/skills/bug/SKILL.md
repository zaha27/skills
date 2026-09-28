---
name: bug
description: Log a bug to docs/BUGS.md with an ID, severity and the roadmap milestone it belongs to, without fixing it. `/zaha:bug list` shows open bugs.
argument-hint: "<what is wrong> | list"
disable-model-invocation: true
---

# Bug

Bugs live in `docs/BUGS.md` (root `BUGS.md` if that already exists; then keep its format). IDs are `B-<nnn>`, never reused. **Log, don't fix**: I'm probably in the middle of something else.

## `list`

Show open bugs grouped by severity, one line each (`B-007 [high] M2 · Login fails on Safari`), then `Suggested: /zaha:planning <top ID>`. Stop.

## No arguments

Ask what the bug is in one question. Then log it.

## Log a bug

1. **Duplicates:** grep `docs/BUGS.md` for the key words. If an open bug looks like the same one, ask whether to add the new details to it instead.
2. **ID:** the highest existing number + 1, counting Open and Fixed. Start at `B-001`.
3. **Severity:**
   - `high`: breaks a core flow, loses data, or is a security issue.
   - `med`: wrong behavior with a workaround.
   - `low`: cosmetic.
4. **Milestone:** the roadmap milestone of the affected feature; else the one `[in progress]`; else `-`.
5. **Where (optional):** at most one or two greps to point at the likely file. Don't read further and don't diagnose; that's `/zaha:planning`'s job.
6. **Write** the entry at the top of `## Open`. If the bug blocks a roadmap task, append `(B-007)` to that task line. If it's `high` and no task covers it, ask whether to add one.

If the description is too vague to reproduce, ask one question about it. Otherwise don't ask.

## Format

```markdown
# Bugs

## Open

### B-007 [high] M2 · Login fails on Safari
Found: 2026-09-28
Repro: log in on Safari 17 with valid credentials → bounced back to /login
Expected: lands on /dashboard
Where: src/auth/session.ts (cookie options), unconfirmed

## Fixed

- B-004 [med] M2 · Reset email sent twice · fixed 2026-09-27 in e4f5a6b
```

Open bugs get a heading and details; fixed ones collapse to one line (`/zaha:recap` moves them).

## Reply

One line: `Logged B-007 [high] M2 · Login fails on Safari`, plus the blocked task if any, and `Fix it: /zaha:planning B-007`.
