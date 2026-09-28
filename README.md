# skills

My Claude Code skills and plugins, shared across machines.

## Install

**Skills** (cloned repo, symlinked into `~/.claude/skills/`):

```sh
git clone https://github.com/zaha27/skills ~/Documents/GitHub/skills
~/Documents/GitHub/skills/install.sh
```

On my Mac, [dotfiles](https://github.com/zaha27/dotfiles)' `install.sh` does this for me.

**Plugins** (no clone needed), in Claude Code:

```
/plugin marketplace add zaha27/skills
/plugin install <name>@zaha-skills
```

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
