#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh
name=$(openssl rand -hex 4)
tag=$(openssl rand -hex 4)
docker build -t "${name}:${tag}" .
snyk container test "${name}:${tag}"
