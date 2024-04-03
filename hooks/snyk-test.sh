#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of dependency files
if find . \( -name 'package.json' -o -name 'package-lock.json' -o -name 'yarn.lock' -o -name 'Gemfile' -o -name 'Gemfile.lock' -o -name 'requirements.txt' -o -name 'Pipfile' -o -name 'Pipfile.lock' -o -name 'composer.json' -o -name 'composer.lock' -o -name 'go.mod' -o -name 'go.sum' -o -name 'Gopkg.toml' -o -name 'Gopkg.lock' -o -name 'build.gradle' -o -name 'pom.xml' -o -name 'Cargo.toml' -o -name 'Cargo.lock' \) -print -quit &>/dev/null; then
  snyk test "$@"
else
  echo "Warning: No supported dependency files detected. Skipping Snyk dependency test."
fi
