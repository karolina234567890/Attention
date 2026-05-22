#!/bin/bash
set -euo pipefail

# Only run in remote (web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install all obra/superpowers skills
SKILLS_REPO="/tmp/superpowers"

if [ ! -d "$SKILLS_REPO" ]; then
  git clone --depth=1 https://github.com/obra/superpowers "$SKILLS_REPO"
fi

for skill_dir in "$SKILLS_REPO"/skills/*/; do
  name=$(basename "$skill_dir")
  target="$HOME/.claude/skills/obra-superpowers-$name"
  mkdir -p "$target"
  cp "$skill_dir/SKILL.md" "$target/SKILL.md"
done

echo "obra/superpowers skills installed."
