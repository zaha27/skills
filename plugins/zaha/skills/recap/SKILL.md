---
name: recap
description: Summarize what changed since the last recap (commits, uncommitted work, decisions from this session) into docs/HISTORY.md, tick finished roadmap tasks and fixed bugs, and suggest the next step.
argument-hint: "[range or note, e.g. 'since monday']"
disable-model-invocation: true
---

# Recap

History lives in `docs/HISTORY.md`, newest entry first. Related files: the roadmap (`docs/ROADMAP.md` or root `ROADMAP.md`, owned by `/zaha:roadmap`) and `docs/BUGS.md` (owned by `/zaha:bug`). If an equivalent history file already exists (`HISTORY.md` at the root), use it and keep its format. Never write into `CHANGELOG.md`: that is release notes for users, not this log.

## 1. Find the range

- If history exists: start after the last commit named on the top entry's `Commits:` line.
- If it doesn't, or that commit is gone: use the last 7 days, capped at 30 commits, and say so in the entry.
- If I passed a range or note, it wins.

## 2. Gather cheaply

- `git log --oneline <from>..HEAD` and `git diff --stat <from>..HEAD | tail -1`.
- `git status -s` for uncommitted work.
- What we did and decided in this conversation, if anything. Decisions that are not in any commit matter most.
- Read a diff hunk only when a commit message doesn't say what changed. Never read the full diff.

## 3. Write the entry

Group by outcome, not by commit. 3 to 7 bullets, each one line. Put the entry at the top, under the title:

```markdown
# History

## 2026-09-28 · M2 Auth
Commits: a1b2c3d..e4f5a6b (7)
- Added password reset: emailed token, expires after 1h
- Fixed B-004: Safari dropped the session cookie (SameSite)
- Decided: sessions stay cookie-based, no JWT
- Uncommitted: rate-limit middleware, half done
Done: M2.3, B-004
Next: M2.4 Rate-limit login
```

- `Commits:` uses short hashes: first and last commit of the range, then the count. Omit the line when there are no new commits.
- `Done:` lists only IDs with evidence, meaning a commit or my word.

## 4. Update the other files

- Roadmap: tick the tasks listed in `Done:`. If a whole milestone is done, mark it `[done]` and the next one `[in progress]`.
- Bugs: move each fixed bug from Open to Fixed, in the format `/zaha:bug` uses, with the date and the commit.
- Don't add new tasks or bugs here. List candidates under the reply instead, e.g. "Not tracked yet: flaky login test → /zaha:bug?".

## 5. Reply

Show the entry as written, then one line naming the ticked IDs, then `Suggested: /zaha:planning <next ID>`. Don't commit anything.
