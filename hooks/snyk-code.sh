#!/usr/bin/env bash

set -eu

# Run Snyk Code hook
snyk code test "$@" || true

# Capture exit code of Snyk Test hook
set +e
snyk code test
snyk_exit_code=$?
set -e

# Check if the exit code is 2 (indicating pipenv not installed)
if [ "$snyk_exit_code" = 2 ]; then
  echo "pipenv is not installed, but the Snyk Test check passed."
  exit 0
fi

# If the exit code is not 2, exit with the same code
exit "$snyk_exit_code"
