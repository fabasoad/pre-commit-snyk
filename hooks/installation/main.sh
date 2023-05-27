#!/usr/bin/env bash
set -eu

if ! command -v snyk &> /dev/null
then
  SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
  if command -v brew &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-brew.sh
  elif command -v scoop &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-scoop.sh
  elif command -v npm &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-npm.sh
  elif command -v yarn &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-yarn.sh
  else
    bash "${SCRIPT_DIR}"/install-standalone.sh
  fi
fi
