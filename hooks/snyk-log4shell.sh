#!/usr/bin/env sh
set -eu

SCRIPT_PATH=$(realpath "$0")
HOOKS_FOLDER_PATH=$(dirname "${SCRIPT_PATH}")
INSTALLATION_FOLDER_PATH="${HOOKS_FOLDER_PATH}/installation"

sh "${INSTALLATION_FOLDER_PATH}/main.sh"

snyk log4shell "$@"
