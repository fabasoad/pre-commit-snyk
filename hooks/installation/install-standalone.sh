#!/bin/bash
set -eu

if [[ -f "/etc/alpine-release" ]]; then
  binary="snyk-alpine"
  path="/usr/local/bin/"
else
  case "$(uname -s)" in
    Darwin*)
      binary="snyk-macos"
      path="/usr/local/bin/"
      ;;
    MINGW64*)
      binary="snyk-win.exe"
      path="C:\Windows\System32"
      ;;
    MSYS_NT*)
      binary="snyk-win.exe"
      path="C:\Windows\System32"
      ;;
    *)
      if [[ "$(uname -m)" == "arm64" ]]; then
        binary="snyk-linux-arm64"
      else
        binary="snyk-linux"
      fi
      path="/usr/local/bin/"
      ;;
  esac
fi

prefix="[pre-commit-snyk]"

url="https://static.snyk.io/cli/latest/$binary"
printf "%s GET %s" "$prefix" "$url"
curl $url -o snyk
chmod +x ./snyk
mv ./snyk $path
