
#!/bin/bash
# Build and deploy Tola site to GitHub Pages.
set -euo pipefail

cd "$(dirname "$0")"

# Clean previous build.
rm -rf public

# Build the site.
tola build

# Check build output.
if [ ! -d "public" ]; then
    echo "Error: public/ directory not found."
    exit 1
fi

# Get GitHub remote.
REMOTE=$(git remote get-url origin)

# Prepare temporary deployment directory.
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Copy generated website.
cp -R public/. "$TMP"/

# Disable Jekyll.
touch "$TMP/.nojekyll"

# Deploy to gh-pages.
cd "$TMP"
git init -q -b gh-pages
git add -A
git -c user.name="GitHub Pages Deploy" \
    -c user.email="deploy@example.com" \
    commit -q -m "Deploy $(date -u +%Y-%m-%dT%H:%M:%SZ)"

git push -f "$REMOTE" gh-pages

echo "Deployment successful!"
