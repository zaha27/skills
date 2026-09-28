# skills

My Claude Code skills, shipped two ways:

- `plugins/zaha/`: the public `zaha` plugin, listed in `.claude-plugin/marketplace.json` (marketplace `zaha-skills`). Skills are invoked as `/zaha:<name>`.
- `skills/`: personal, unpublished skills. `install.sh` symlinks each into `~/.claude/skills/`.

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

These skills live in `plugins/zaha/skills/`. The owner skill creates the file; every other skill follows the file as it finds it. If the project already has an equivalent file (e.g. `ROADMAP.md` at the root), use it and keep its format; never create a second one. IDs: tasks `M<n>.<k>`, bugs `B-<nnn>`; never renumbered or reused.

Loop (all `/zaha:<name>`): `roadmap` → `planning` → implement → `test` → `bug` → `recap` → `planning` …

## Adding a skill

- **Plugin skill:** create `plugins/zaha/skills/<name>/SKILL.md`, try it with `claude --plugin-dir plugins/zaha` in a real project, bump `version` in `plugins/zaha/.claude-plugin/plugin.json`, run `claude plugin validate . --strict`.
- **Personal skill:** create `skills/<name>/SKILL.md`, run `./install.sh`.
- Then add it to `README.md` and commit `feat(skill): <name>`.
- After a plugin version bump is pushed: `gh release create v<version> --generate-notes` so GitHub releases match `plugin.json`.

Credit: the grilling step in `/planning`, `handoff` and `what` are adapted from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT).
