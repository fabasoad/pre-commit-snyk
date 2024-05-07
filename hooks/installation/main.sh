#!/usr/bin/env sh
# shellcheck disable=SC2039,SC3020
set -eu

SCRIPT_PATH=$(realpath "$0")
INSTALLATION_FOLDER_PATH=$(dirname "${SCRIPT_PATH}")

if ! command -v snyk &> /dev/null; then
  if command -v brew &> /dev/null; then
    sh "${INSTALLATION_FOLDER_PATH}/install-brew.sh"
  elif command -v scoop &> /dev/null; then
    sh "${INSTALLATION_FOLDER_PATH}/install-scoop.sh"
  elif command -v npm &> /dev/null; then
    sh "${INSTALLATION_FOLDER_PATH}/install-npm.sh"
  elif command -v yarn &> /dev/null; then
    sh "${INSTALLATION_FOLDER_PATH}/install-yarn.sh"
  else
    sh "${INSTALLATION_FOLDER_PATH}/install-standalone.sh"
  fi
fi
