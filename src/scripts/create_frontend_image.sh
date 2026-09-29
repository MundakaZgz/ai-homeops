#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

docker build -t ai-homeops-front -f "${REPO_ROOT}/src/frontend/Dockerfile" "${REPO_ROOT}"