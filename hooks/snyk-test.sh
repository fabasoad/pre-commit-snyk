#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

bash "${SCRIPT_DIR}"/installation/main.sh

snyk test "$@"
snyk_exit_code=$?

set +e
if [ "$snyk_exit_code" = 2 ] || [ "$snyk_exit_code" = 3 ]; then
  echo "No supported projects detected"
  exit 0
fi
set -e
