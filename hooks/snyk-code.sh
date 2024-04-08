#!/usr/bin/env bash

set -eu

# Capture exit code of Snyk Test hook
set +e
snyk code test
snyk_exit_code=$?
set -e

# Check if the exit code is 2
if [ "$snyk_exit_code" = 2 ] || [ "$snyk_exit_code" = 3 ]; then
  echo "Valid files not found."
  exit 0
fi

# If the exit code is not 2, exit with the same code
exit "$snyk_exit_code"
