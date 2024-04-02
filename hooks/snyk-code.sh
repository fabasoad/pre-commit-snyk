#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of code files
if ! ls *.js *.ts *.java *.py &> /dev/null; then
  echo "Warning: No code files detected. Skipping Snyk code test."
else
  snyk code test "$@"
fi
