#!/bin/bash
set -eu

if ! command -v snyk &> /dev/null
then
  npm install snyk@latest -g
fi
