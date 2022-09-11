#!/bin/bash
set -eu

if ! command -v snyk &> /dev/null
then
  if command -v yarn &> /dev/null
  then
    yarn global add snyk
  else
    npm install snyk@latest -g
  fi
fi
