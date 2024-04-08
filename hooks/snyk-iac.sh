#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

bash "${SCRIPT_DIR}"/installation/main.sh

set +e
snyk_exist_code=$(snyk iac test)
if [ "$snyk_exist_code" = 0 ]; then
  echo "No vulnerabilities found"
  exit 0
else
  echo "Vulnerabilities found"
  exit "$snyk_exist_code"
fi