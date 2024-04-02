#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

printf "Executing test hook\n" >&2

# Check for the presence of test files
if ! ls *test.js *test.ts *test.py &> /dev/null; then
  printf "Warning: No test files detected. Skipping Snyk test.\n" >&2
  exit 0
fi

snyk test "$@"
