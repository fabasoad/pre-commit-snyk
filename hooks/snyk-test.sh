#!/usr/bin/env bash

set -eu

# Capture exit code of Snyk Test hook
set +e
snyk test
snyk_exit_code=$?
set -e

# Check if the exit code is 2
if [ "$snyk_exit_code" = 2 ]; then
  echo "Error, try running manually, use -d to output debug logs."
  exit 0
fi

if [ "$snyk_exit_code" = 3 ]; then
  echo "Valid files not found."
  exit 0
fi

# If the exit code is not 2, exit with the same code
exit "$snyk_exit_code"
