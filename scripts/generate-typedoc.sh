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
  git config --global credential.helper \
    '!f() { echo "username=x-access-token"; echo "password=${GH_TOKEN}"; }; f'
fi

echo "Cloning gettakaro/takaro@${REF} ..."
git clone --depth 1 --branch "$REF" "$CLONE_URL" "$WORK_DIR/takaro"

echo "Installing dependencies ..."
cd "$WORK_DIR/takaro"
npm ci

mkdir -p reports

# Extract prebuilt dist/ directories from ECR containers
if [[ -n "${ECR_REGISTRY:-}" ]]; then
  echo "Extracting prebuilt packages from ECR containers ..."

  for IMAGE in takaro-app-api takaro-app-connector; do
    CID=$(docker create "${ECR_REGISTRY}/${IMAGE}:latest")
    # Extract all package dist dirs from the container
    docker cp "${CID}:/app/packages/" "$WORK_DIR/extracted-${IMAGE}/" 2>/dev/null || true
    docker rm "$CID" > /dev/null

    # Overlay dist/ directories onto the source tree
    for pkg_dir in "$WORK_DIR/extracted-${IMAGE}"/*/; do
      pkg_name=$(basename "$pkg_dir")
      if [[ -d "${pkg_dir}dist" && -d "packages/${pkg_name}" ]]; then
        cp -r "${pkg_dir}dist" "packages/${pkg_name}/"
        echo "  Extracted dist/ for ${pkg_name}"
      fi
    done
  done
else
  echo "Warning: ECR_REGISTRY not set — running TypeDoc without prebuilt packages"
fi

# Remove test files — they import dev-only packages (@takaro/test, @takaro/mock-gameserver)
# that are not in the production ECR containers
find packages -type d \( -name __tests__ -o -name __test__ \) -exec rm -rf {} + 2>/dev/null || true
find packages -name '*.test.ts' -delete 2>/dev/null || true

echo "Generating TypeDoc ..."
npx typedoc --skipErrorChecking || true

if [[ -d reports/api-docs ]]; then
  echo "Copying API docs to ${DOCS_ROOT}/static/api-docs/ ..."
  rm -rf "${DOCS_ROOT}/static/api-docs"
  cp -r reports/api-docs "${DOCS_ROOT}/static/api-docs"
  echo "Done — TypeDoc output is at static/api-docs/"
else
  echo "Error: TypeDoc did not produce output at reports/api-docs"
  exit 1
fi
