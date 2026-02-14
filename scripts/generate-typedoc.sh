#!/usr/bin/env bash
set -euo pipefail

REF="${1:-main}"
CLONE_URL="https://github.com/gettakaro/takaro.git"
DOCS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK_DIR="$(mktemp -d)"

cleanup() { rm -rf "$WORK_DIR"; }
trap cleanup EXIT

# Configure git credential helper if GH_TOKEN is set
if [[ -n "${GH_TOKEN:-}" ]]; then
  # GH_TOKEN must expand at git-invocation time, not config time
  # shellcheck disable=SC2016
  git config --global credential.helper '!f() { echo "username=x-access-token"; echo "password=${GH_TOKEN}"; }; f'
fi

echo "Cloning gettakaro/takaro@${REF} ..."
git clone --depth 1 --branch "$REF" "$CLONE_URL" "$WORK_DIR/takaro"

echo "Installing dependencies ..."
cd "$WORK_DIR/takaro"
npm ci

mkdir -p reports

echo "Generating TypeDoc ..."
npm run typedoc

echo "Copying API docs to ${DOCS_ROOT}/static/api-docs/ ..."
rm -rf "${DOCS_ROOT}/static/api-docs"
cp -r reports/api-docs "${DOCS_ROOT}/static/api-docs"

echo "Done — TypeDoc output is at static/api-docs/"
