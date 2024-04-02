#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of test files
if ! ls *test.js *test.ts *test.py &> /dev/null; then
  echo "Warning: No test files detected. Skipping Snyk test."
else
  snyk test "$@"
fi
