#!/usr/bin/env sh
set -eu

scoop --version
cmd /c ver
scoop bucket add snyk https://github.com/snyk/scoop-snyk
scoop install snyk
