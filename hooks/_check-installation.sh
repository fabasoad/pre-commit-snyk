#!/bin/bash
set -eu

if ! command -v snyk &> /dev/null
then
  echo "snyk is not installed"
  if [ "$(uname -s)" = "Darwin" ]; then
     os="macos"
  elif [[ $(which apk) ]]; then
     os="alpine"
  elif [[ $(which apt) ]]; then
     os="linux"
  else
     os="win"
  fi

  INSTALLATION_DIR="${HOME}"/bin
  mkdir -p "${INSTALLATION_DIR}"
  curl -s https://static.snyk.io/cli/latest/release.json | jq ".assets.\"snyk-${os}\".url" | xargs curl --output "${INSTALLATION_DIR}"/snyk
  export PATH="${INSTALLATION_DIR}/:$PATH"
fi
