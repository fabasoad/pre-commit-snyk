#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of code files
if find . \(-o -name '*.js' -o -name '*.jsx' -o -name '*.ts' -o -name '*.tsx' -o -name '*.java' -o -name '*.py' -o -name '*.rb' -o -name '*.go' -o -name '*.kt' -o -name '*.kts' -o -name '*.swift' -o -name '*.rs' -o -name '*.scala' -o -name '*.sh' -o -name '*.html' -o -name '*.css' -o -name '*.yaml' -o -name '*.yml' -o -name '*.json' \) -print -quit &>/dev/null; then
  snyk code test "$@"
else
  echo "Warning: No supported code files detected. Skipping Snyk code test."
fi
