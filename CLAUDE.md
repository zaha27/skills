# skills

My personal Claude Code skills. `install.sh` symlinks each `skills/<name>/` into `~/.claude/skills/`, so edits here are live.

## Writing a SKILL.md

- English. Frontmatter `name` + `description` (what it does and when to use it).
- **User-invoked by default**: `disable-model-invocation: true`. The skill is then invisible to the model until I type `/<name>`, so it costs 0 context tokens. Make a skill model-invoked only when Claude must reach for it on its own.
- Short: `SKILL.md` under ~100 lines. Longer details go in `references/` inside the skill folder, read only when needed.
- One skill, one job. Imperative steps; say what the output looks like.
- Cheap by default: search before reading, `head`/`tail`/`grep` long output, never read whole source trees.
- Never delete, commit or push from a skill unless the step says to ask first.

## Workflow skills

`roadmap`, `recap`, `bug`, `planning`, `test` share three files in each project:

| File | Owner (defines the format) |
|---|---|
| `docs/ROADMAP.md` | `/roadmap` |
| `docs/BUGS.md` | `/bug` |
| `docs/HISTORY.md` | `/recap` |

The owner skill creates the file; every other skill follows the file as it finds it. IDs: tasks `M<n>.<k>`, bugs `B-<nnn>`; never renumbered or reused.

Loop: `/roadmap` → `/planning` → implement → `/test` → `/bug` → `/recap` → `/planning` …

## Adding a skill

1. Create `skills/<name>/SKILL.md`, run `./install.sh`.
2. Try it on a real project.
3. Add it to the list in `README.md`, commit `feat(skill): <name>`.

Credit: the grilling step in `/planning` is adapted from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT).
