#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of code files
FIND_RESULT=$(find . \( -name '*.apex' -o -name '*.ASPX' -o -name '*.c' -o -name '*.cc' -o -name '*.cjs' -o -name '*.cls' -o -name '*.cpp' -o -name '*.CS' -o -name '*.ejs' -o -name '*.erb' -o -name '*.es' -o -name '*.es6' -o -name '*.go' -o -name '*.h' -o -name '*.haml' -o -name '*.hpp' -o -name '*.htm' -o -name '*.html' -o -name '*.hxx' -o -name '*.java' -o -name '*.js' -o -name '*.jspx' -o -name '*.jsx' -o -name '*.jsp' -o -name '*.kt' -o -name '*.mjs' -o -name '*.php' -o -name '*.py' -o -name '*.rb' -o -name '*.rhtml' -o -name '*.scala' -o -name '*.slim' -o -name '*.swift' -o -name '*.ts' -o -name '*.tsx' -o -name '*.trigger' -o -name '*.vb' -o -name '*.vue' -o -name '*.xml' \) -print -quit)

if [ -n "$FIND_RESULT" ]; then
  echo "Matching files found: $FIND_RESULT"
  snyk code test "$@"
else
  echo "No supported code files detected. Skipping Snyk code test."
  exit 0  # Exiting with success (0) status code
fi
