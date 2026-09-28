#!/usr/bin/env bash
# Link every skill in skills/ into ~/.claude/skills/. Idempotent: safe to re-run.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"

for src in "$REPO"/skills/*/; do
  [[ -d "$src" ]] || continue
  src="${src%/}" name="$(basename "$src")" dst="$DEST/$(basename "$src")"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then continue; fi
  if [[ -e "$dst" || -L "$dst" ]]; then echo "skipped $dst (already exists, not ours)"; continue; fi
  ln -s "$src" "$dst" && echo "linked $name"
done
