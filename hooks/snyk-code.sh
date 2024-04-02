#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

printf "Executing code-test hook\n" >&2

# Check for the presence of code files
if ! ls *.js *.ts *.java *.py &> /dev/null; then
  printf "Warning: No code files detected. Skipping Snyk code test.\n" >&2
  exit 0
fi

snyk code test "$@"
