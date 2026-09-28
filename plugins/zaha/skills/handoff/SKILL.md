---
name: handoff
description: Before /clear, write a short handoff of the current session (goal, state, decisions, exact next step) so a fresh session can continue without the old context.
argument-hint: "[what the next session will focus on]"
disable-model-invocation: true
---

# Handoff

Write the handoff to `~/.claude/handoffs/<repo-name>.md` (outside the repo; overwrite the previous one for this repo). `<repo-name>` is the basename of `git rev-parse --show-toplevel`, or of the current folder.

If I passed arguments, they describe what the next session will do: tailor the handoff to that.

## Content

At most ~40 lines:

```markdown
# Handoff: <repo> · <date>

Goal: <what we are trying to achieve, one sentence>   (M3.2 / B-004)

Done this session:
- <result>, in `path/file.py`

In progress:
- <what is half done, and where it stops>

Decisions:
- <decision>, because <reason>

Open questions:
- <question only I can answer>

Next:
1. <exact first step, with the file or command>
2. ...

Verify with: `<test or command>`
Suggested: /zaha:<skill> <args>
```

- Reference, don't copy: point to roadmap and bug IDs, commits, `docs/HISTORY.md` and file paths instead of repeating their content.
- Include what exists nowhere else: half-done work, decisions and their reasons, dead ends already tried.
- Leave out empty sections.
- Never include secrets, tokens or passwords.

## Reply

Show the path, then one line to paste into the new session:

```
Continue from ~/.claude/handoffs/<repo-name>.md
```

If there is uncommitted work, say so. If the session changed project state, suggest `/zaha:recap` before `/clear`.
