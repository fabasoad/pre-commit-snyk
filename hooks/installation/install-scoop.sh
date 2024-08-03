#!/usr/bin/env sh
set -eu

echo "~ Scoop version:"
scoop --version
echo "~ Windows version:"
cmd /c ver
echo "~~~~"
scoop bucket add snyk https://github.com/snyk/scoop-snyk
scoop install snyk
