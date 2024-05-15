#!/usr/bin/env sh
set -u

SCRIPT_PATH=$(realpath "$0")
HOOKS_FOLDER_PATH=$(dirname "${SCRIPT_PATH}")
INSTALLATION_FOLDER_PATH="${HOOKS_FOLDER_PATH}/installation"

sh "${INSTALLATION_FOLDER_PATH}/main.sh"

# Capture exit code of Snyk Test hook
set +e
snyk iac test "$@"
snyk_exit_code=$?
set -e

# Check if the exit code is 3
if [ "$snyk_exit_code" = 3 ]; then
  exit 0
fi

exit "$snyk_exit_code"
