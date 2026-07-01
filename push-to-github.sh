#!/bin/bash
# Push Season app commits to GitHub (run after: gh auth login)
set -e
cd "$(dirname "$0")"

echo "→ Checking GitHub login..."
if ! gh auth status >/dev/null 2>&1; then
  echo ""
  echo "Not logged in. Run first:"
  echo "  gh auth login"
  echo ""
  echo "Then run this script again:"
  echo "  ./push-to-github.sh"
  exit 1
fi

echo "→ Pushing to origin/main..."
git push origin main

echo ""
echo "✅ Done! Backend handoff:"
echo "   https://github.com/minaypclub/season_app/tree/main/backend/laravel"
