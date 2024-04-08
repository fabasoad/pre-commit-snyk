#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

bash "${SCRIPT_DIR}"/installation/main.sh

set +e
snyk_exist_code=$(snyk test ...)
if [ "$snyk_exist_code" = 3 ]; then
  echo "No supported projects detected"
  exit 0
else
  snyk iac test "$@"
fi
set -e
exit "$snyk_exist_code"