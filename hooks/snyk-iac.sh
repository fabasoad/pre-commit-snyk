#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of IaC files
if ! ls *.tf *.yaml *.yml &> /dev/null; then
  echo "Warning: No IaC files detected. Skipping Snyk IaC test."
else
  snyk iac test "$@"
fi
