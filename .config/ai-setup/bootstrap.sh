mkdir -p .knowledge

cat <<'EOF' >.knowledge/watch.sh
  #!/usr/bin/env bash

  set -euo pipefail

  echo "🚀 Bootstrapping Code Review Graph + Claude..."

  # ------------------------------------------------------------------
  # Install Code Review Graph Claude integration if not already present
  # ------------------------------------------------------------------
  if [ ! -d ".claude" ]; then
    echo "Installing Claude integration..."

    # Auto-answer "yes" to the injection prompt
    printf 'y\n' | code-review-graph install --platform claude

    echo "Claude integration installed."
  else
    echo ".claude already exists, skipping install."
  fi

  # ------------------------------------------------------------------
  # Create compatibility symlinks
  # ------------------------------------------------------------------

  # .agents -> .claude
  if [ ! -e ".agents" ] && [ -d ".claude" ]; then
    ln -s .claude .agents
    echo "Created .agents -> .claude"
  fi

  # AGENTS.md -> CLAUDE.md
  if [ ! -e "AGENTS.md" ] && [ -f "CLAUDE.md" ]; then
    ln -s CLAUDE.md AGENTS.md
    echo "Created AGENTS.md -> CLAUDE.md"
  fi

  # ------------------------------------------------------------------
  # Initial graph build/update
  # ------------------------------------------------------------------
  if [ ! -d ".code-review-graph" ]; then
    echo "Building initial graph..."
    code-review-graph build
  else
    echo "Updating existing graph..."
    code-review-graph update || true
  fi

  echo ""
  echo "✅ Ready"
  echo ""

  # ------------------------------------------------------------------
  # Watch for file changes
  # ------------------------------------------------------------------
  if ! command -v fswatch >/dev/null 2>&1; then
    echo "❌ fswatch is not installed."
    echo "Install with:"
    echo "  brew install fswatch"
    exit 1
  fi

  echo "👀 Watching for changes..."

  fswatch -o . \
    --exclude="\\.git" \
    --exclude="node_modules" \
    --exclude="bin" \
    --exclude="obj" \
    --exclude="\\.next" \
    --exclude="dist" \
    --exclude="\\.knowledge" \
    --exclude="\\.code-review-graph" \
    --exclude="\\.claude" |
    while read -r; do
      echo ""
      echo "[$(date '+%Y-%m-%d %H:%M:%S')] Updating knowledge graph..."

      code-review-graph update || true
    done
EOF

chmod +x .knowledge/watch.sh

echo "🎉 .knowledge/watch.sh was successfully written and set to executable without manual execution."
