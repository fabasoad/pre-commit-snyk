#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of infrastructure as code files
FIND_RESULT=$(find . \( -name '*.tf' -o -name '*.hcl' -o -name '*.yml' -o -name '*.yaml' -o -name '*.json' -o -name '*.tfvars' -o -name '*.tfstate' -o -name '*.tfstate.backup' -o -name '*.tf.json' \) -print -quit)

if [ -n "$FIND_RESULT" ]; then
  echo "Matching files found: $FIND_RESULT"
  snyk iac test "$@"
else
  echo "No supported infrastructure as code files detected. Skipping Snyk IaC test."
  exit 0  # Exiting with success (0) status code
fi
