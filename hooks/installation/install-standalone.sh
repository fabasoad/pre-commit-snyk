#!/bin/bash
set -eu

if [[ -f "/etc/alpine-release" ]]; then
  binary="snyk-alpine"
else
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
fi

echo "GET https://static.snyk.io/cli/latest/$binary"

curl https://static.snyk.io/cli/latest/$binary -o snyk
chmod +x ./snyk
