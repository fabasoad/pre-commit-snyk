#!/bin/bash
set -eu

case "$(uname -s)" in
  Darwin*)
    binary="snyk-macos"
    ;;
  MINGW64*)
    binary="snyk-win.exe"
    ;;
  MSYS_NT*)
    binary="snyk-win.exe"
    ;;
  *)
    if [[ "$(uname -m)" == "arm64" ]]; then
      binary="snyk-linux-arm64"
    else
      binary="snyk-linux"
    fi
    ;;
esac

if [[ "$(uname -a)" == *"alpine"* ]]; then
  binary="snyk-alpine"
fi

echo "GET https://static.snyk.io/cli/latest/$binary"

curl https://static.snyk.io/cli/latest/$binary -o snyk
chmod +x ./snyk
PATH=$PATH:$(pwd)
