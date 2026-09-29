#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

docker build -t ai-homeops-back -f "${REPO_ROOT}/src/backend/Dockerfile" "${REPO_ROOT}"
