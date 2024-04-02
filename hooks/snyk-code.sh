#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of code files
if ls *.js *.jsx *.mjs *.ts *.tsx *.java *.py *.rb *.go *.kt *.kts *.swift *.php *.rs *.c *.h *.cpp *.cxx *.cc *.hpp *.hxx *.cs *.scala *.pl *.pm *.sh *.bash *.zsh *.html *.htm *.css *.yaml *.yml *.json &> /dev/null; then
  snyk code test "$@"
else
  echo "Warning: No code files detected. Skipping Snyk code test."
fi
