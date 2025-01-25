#!/usr/bin/env bash

FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT=1

_fail() {
  exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE:-${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}}"
  if ! [ "${exit_code}" -eq "${exit_code}" ] 2>/dev/null; then
    exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}"
  fi
  exit "${exit_code}"
}

# Validates value to be a valid semver string.
# Parameters:
# 1. (Required) Param value that will be validated.
# 2. (Optional) Param name to display it correctly in the error message for the
#    users.
#
# Usage examples:
# fabasoad_validate_semver "1.2.3" "my-valid-semver-1"
# fabasoad_validate_semver "1.2.3-rc-1" "my-valid-semver-2"
# fabasoad_validate_semver "1.1.2+meta"
#
# Reference:
# Validation logic is taken from https://github.com/semver/semver/issues/981
fabasoad_validate_semver() {
  # Regex for a semver digit
  D='0|[1-9][0-9]*'
  # Regex for a semver pre-release word
  PW='[0-9]*[a-zA-Z-][0-9a-zA-Z-]*'
  # Regex for a semver build-metadata word
  MW='[0-9a-zA-Z-]+'

  if ! [[ "${1}" =~ ^($D)\.($D)\.($D)(-(($D|$PW)(\.($D|$PW))*))?(\+($MW(\.$MW)*))?$ ]]; then
    msg=""
    if [ -n "${2:-""}" ]; then
      msg="${msg}\"${2}\" parameter is invalid. "
    fi
    printf "%s\"%s\" is not a valid semver.\n" "${msg}" "${1}" >&2
    _fail
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_validate_semver
else
  fabasoad_validate_semver "${@}"
  exit $?
fi
