#!/usr/bin/env bash

FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT=1

_fail() {
  exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE:-${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}}"
  if ! [ "${exit_code}" -eq "${exit_code}" ] 2>/dev/null; then
    exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}"
  fi
  exit "${exit_code}"
}

# Validates that passed value is a path to an existing directory.
# Parameters:
# 1. (Required) Param value that will be validated.
# 2. (Optional) Param name to display it correctly in the error message for the
#    users.
#
# Usage example:
# fabasoad_validate_dir_exists "/usr/local/my-dir" "my-dir-param"
# fabasoad_validate_dir_exists "./project"
fabasoad_validate_dir_exists() {
  if [ ! -d "${1}" ]; then
    msg=""
    if [ -n "${2:-""}" ]; then
      msg="${msg}\"${2}\" parameter is invalid. "
    fi
    printf "%s\"%s\" is not a directory or does not exist.\n" "${msg}" "${1}" >&2
    _fail
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_validate_dir_exists
else
  fabasoad_validate_dir_exists "${@}"
  exit $?
fi
