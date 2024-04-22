#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Capture exit code of Snyk Test hook
set +e
snyk code test "$@"
snyk_exit_code=$?
set -e

# Check if the exit code is 3
if [ "$snyk_exit_code" = 3 ]; then
  exit 0
fi

exit "$snyk_exit_code"
