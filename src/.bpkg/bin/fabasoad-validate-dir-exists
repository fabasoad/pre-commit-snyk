#!/usr/bin/env bash

fabasoad_validate_dir_exists() {
  param_key="${1}"
  param_val="${2}"
  if [ ! -d "${param_val}" ]; then
    printf "\"%s\" parameter is invalid. \"%s\" is not a directory or does not exist.\n" "${param_key}" "${param_val}" >&2
    exit 1
  fi
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_validate_dir_exists
else
  fabasoad_validate_dir_exists "${@}"
  exit $?
fi
