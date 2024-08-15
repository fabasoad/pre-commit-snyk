#!/usr/bin/env bash

# Validation logic is taken from https://github.com/semver/semver/issues/981
fabasoad_validate_semver() {
  param_key="${1}"
  param_val="${2}"

  # Regex for a semver digit
  D='0|[1-9][0-9]*'
  # Regex for a semver pre-release word
  PW='[0-9]*[a-zA-Z-][0-9a-zA-Z-]*'
  # Regex for a semver build-metadata word
  MW='[0-9a-zA-Z-]+'

  if ! [[ "${param_val}" =~ ^($D)\.($D)\.($D)(-(($D|$PW)(\.($D|$PW))*))?(\+($MW(\.$MW)*))?$ ]]; then
    printf "\"%s\" parameter is invalid. \"%s\" is not a valid semver.\n" "${param_key}" "${param_val}" >&2
    exit 1
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_validate_semver
else
  fabasoad_validate_semver "${@}"
  exit $?
fi
