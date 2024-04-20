#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
sh "${SCRIPT_DIR}/installation/main.sh"

snyk iac test "$@"
