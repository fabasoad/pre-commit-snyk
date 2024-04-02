#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of dependency files
if ls package.json requirements.txt &> /dev/null; then
  snyk test "$@"
else
  echo "Warning: No dependency files detected. Skipping Snyk dependency test."
fi

