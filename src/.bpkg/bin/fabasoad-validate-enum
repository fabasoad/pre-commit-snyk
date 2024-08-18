#!/usr/bin/env bash

fabasoad_validate_enum() {
  param_key="${1}"
  param_val="${2}"
  enum_opts="${3},"
  case ",${enum_opts}" in
    *",${param_val},"*)
      ;;
    *)
      printf "\"%s\" parameter is invalid. Possible values: %s.\n" "${param_key}" "$(echo "${enum_opts%,}" | sed 's/,/, /g')" >&2
      exit 1
      ;;
  esac
}

## export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_validate_enum
else
  fabasoad_validate_enum "${@}"
  exit $?
fi
