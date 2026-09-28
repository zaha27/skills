---
name: test
description: Run the project's tests, affected ones first, with filtered output, and report failures briefly. Offers to log pre-existing failures as bugs.
argument-hint: "[all | file or pattern]"
disable-model-invocation: true
---

# Test

## 1. Find the test command

In this order, stop at the first hit:

1. A `Test:` line or test command in the project `CLAUDE.md`.
2. `package.json` scripts (`test`, `test:unit`); the runner is usually vitest or jest.
3. `pyproject.toml` / `pytest.ini` → `pytest`.
4. `go.mod` → `go test ./...`; `Cargo.toml` → `cargo test`.
5. A `Makefile` `test` target.

If you had to detect it, offer once to add `Test: \`<command>\`` to the project `CLAUDE.md` so next time is instant.

No tests at all: say so and suggest the usual setup for the stack. Don't set it up unless I ask.

## 2. Pick the scope

- **No arguments: affected only.** Take the changed files (`git diff --name-only HEAD` plus untracked) and run only their tests:
  - vitest: `vitest related --run <files>`
  - jest: `jest --findRelatedTests <files>`
  - pytest: the matching `test_*.py` files
  - go: the changed packages
  - If nothing maps to a test, say so and ask whether to run all.
- **`all`**: the full suite.
- **A file or pattern**: exactly that.

Always non-interactive: no watch mode (`--run`, `CI=1`). Skip e2e or browser suites unless I ask; this machine has 16 GB of RAM.

## 3. Run with filtered output

Pipe output: `2>&1 | tail -40`. If failures are cut off, rerun just the failing tests, or grep for `FAIL|Error|assert`. Never dump the whole log.

## 4. Report

```
14 passed, 2 failed (vitest related, 6 files)

✗ auth/session.test.ts > keeps cookie on Safari UA
  expected 302 to be 200 (session.ts:42)
✗ reset.test.ts > token expires after 1h: timeout 5000ms
```

For each failure, say whether it comes from the current change (the test or its source is in the diff) or looks pre-existing. Then:
- Caused by the current change → offer to fix it now.
- Pre-existing → offer `/zaha:bug <one-line summary>`.

Don't fix anything without my ok. When everything passes after a change, suggest `/zaha:recap`.
