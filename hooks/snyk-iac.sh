#!/usr/bin/env bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/installation/main.sh

# Check for the presence of infrastructure as code files
if find . \( -name '*.tf' -o -name '*.hcl' -o -name '*.yml' -o -name '*.yaml' -o  -name '*.json' -o -name '*.tfvars' -o -name '*.tfstate' -o -name '*.tfstate.backup' -o -name '*.tf.json' \) ! -name '.pre-commit-config.yaml' ! -name '.docker-compose.yml'-print; then
  snyk iac test "$@"
else
  echo "Warning: No supported infrastructure as code files detected. Skipping Snyk IaC test."
fi
