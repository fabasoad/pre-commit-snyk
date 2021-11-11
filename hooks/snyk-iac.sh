#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

snyk iac test "$@"
