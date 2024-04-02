#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

echo "Executing code-test hook" >&2

# Check for the presence of code files
if ! ls *.js *.ts *.java *.py &> /dev/null; then
  echo "Warning: No code files detected. Skipping Snyk code test."
  exit 0
fi

snyk code test "$@"
