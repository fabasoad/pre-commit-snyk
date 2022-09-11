#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

if ! command -v snyk &> /dev/null
then
  if command -v yarn &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-yarn.sh
  elif command -v brew &> /dev/null; then
    bash "${SCRIPT_DIR}"/install-brew.sh
  else
    bash "${SCRIPT_DIR}"/install-npm.sh
  fi
fi
