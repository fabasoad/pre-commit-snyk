#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of code files
#if ls *.js *.jsx *.mjs *.ts *.tsx *.java *.py *.rb *.go *.kt *.kts *.swift *.php *.rs *.c *.h *.cpp *.cxx *.cc *.hpp *.hxx *.cs *.scala *.pl *.pm *.sh *.bash *.zsh *.html *.htm *.css *.yaml *.yml *.json &> /dev/null; then
#  snyk code test "$@"
#else
#  echo "Warning: No code files detected. Skipping Snyk code test."
#fi

# Check for the presence of code files
if find . \( -name '*.js' -o -name '*.jsx' -o -name '*.mjs' -o -name '*.ts' -o -name '*.tsx' -o -name '*.java' -o -name '*.py' -o -name '*.rb' -o -name '*.go' -o -name '*.kt' -o -name '*.kts' -o -name '*.swift' -o -name '*.php' -o -name '*.rs' -o -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.cxx' -o -name '*.cc' -o -name '*.hpp' -o -name '*.hxx' -o -name '*.cs' -o -name '*.scala' -o -name '*.pl' -o -name '*.pm' -o -name '*.sh' -o -name '*.bash' -o -name '*.zsh' -o -name '*.html' -o -name '*.htm' -o -name '*.css' -o -name '*.yaml' -o -name '*.yml' -o -name '*.json' \) -print -quit &>/dev/null; then
  snyk code test "$@"
else
  echo "Warning: No code files detected. Skipping Snyk code test."
fi
