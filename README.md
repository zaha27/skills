# skills

My Claude Code skills and plugins, shared across machines.

## Install

**`zaha` plugin** (no clone needed), in Claude Code:

```
/plugin marketplace add zaha27/skills
/plugin install zaha@zaha-skills
```

**Personal skills** (cloned repo, symlinked into `~/.claude/skills/`):

```sh
git clone https://github.com/zaha27/skills ~/Documents/GitHub/skills
~/Documents/GitHub/skills/install.sh
```

On my Mac, [dotfiles](https://github.com/zaha27/dotfiles)' `install.sh` does this for me.

## Skills

### `zaha` plugin

Project workflow, all user-invoked (`/zaha:<name>`), sharing `docs/ROADMAP.md`, `docs/BUGS.md`, `docs/HISTORY.md` in each project:

- **[roadmap](plugins/zaha/skills/roadmap/SKILL.md)**: scaffold or show the project roadmap (milestones + tasks).
- **[recap](plugins/zaha/skills/recap/SKILL.md)**: log what changed since the last recap, tick finished tasks and fixed bugs, suggest the next step.

## Layout

| Path | What |
|---|---|
| `skills/<name>/SKILL.md` | standalone skills, symlinked one per skill into `~/.claude/skills/` |
| `plugins/<name>/` | plugins (skills/commands/agents bundled) |
| `.claude-plugin/marketplace.json` | marketplace listing `plugins/` |
| `install.sh` | links `skills/` into `~/.claude/skills/` |

## Adding things

- **Skill:** create `skills/<name>/SKILL.md`, run `./install.sh`. Edits are live (symlink); push to share.
- **Plugin:** create `plugins/<name>/.claude-plugin/plugin.json` (+ skills/commands/agents),
  add `{ "name": "<name>", "source": "./plugins/<name>" }` to `.claude-plugin/marketplace.json`,
  run `claude plugin validate .`, push, then `/plugin marketplace update zaha-skills`
  and `/plugin install <name>@zaha-skills`.

## License

MIT, see [LICENSE](LICENSE).
