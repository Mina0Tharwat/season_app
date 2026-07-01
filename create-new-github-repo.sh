#!/bin/bash
# Create a NEW GitHub repo with all Season app updates and push.
set -e

REPO_NAME="${1:-season-app-latest}"
VISIBILITY="${2:-private}"  # private | public

cd "$(dirname "$0")"

echo "════════════════════════════════════════"
echo "  Season App → New GitHub Repository"
echo "  Repo name: $REPO_NAME ($VISIBILITY)"
echo "════════════════════════════════════════"
echo ""

if ! command -v gh >/dev/null 2>&1; then
  echo "❌ GitHub CLI (gh) not installed."
  echo "   Install: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "→ Login to GitHub (browser will open)..."
  gh auth login -h github.com -p https -w
fi

echo ""
echo "→ Logged in as: $(gh api user -q .login)"
echo ""

# Commit any remaining local changes
if [ -n "$(git status --porcelain)" ]; then
  echo "→ Committing remaining local changes..."
  git add -A
  git commit -m "Sync latest local changes before new repo publish" || true
fi

echo "→ Creating repo: $REPO_NAME"
if [ "$VISIBILITY" = "public" ]; then
  gh repo create "$REPO_NAME" --public --source=. --remote=season-latest --push
else
  gh repo create "$REPO_NAME" --private --source=. --remote=season-latest --push
fi

URL=$(gh repo view "$REPO_NAME" --json url -q .url)

echo ""
echo "✅ Done!"
echo ""
echo "   Repository: $URL"
echo "   Backend:    $URL/tree/main/backend/laravel"
echo ""
echo "   Send backend team:"
echo "   - GitHub link above"
echo "   - ZIP: ~/Downloads/Season-Apple-Backend-Handoff.zip"
echo ""
