#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of IaC files
if ! ls *.tf *.yaml *.yml &> /dev/null; then
  snyk iac test "$@"
else
  echo "Warning: No code files detected. Skipping Snyk code test."
