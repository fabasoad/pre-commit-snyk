#!/usr/bin/env bash

FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT=1

_fail() {
  exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE:-${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}}"
  if ! [ "${exit_code}" -eq "${exit_code}" ] 2>/dev/null; then
    exit_code="${FABASOAD_VALIDATORS_CONFIG_EXIT_CODE_DEFAULT}"
  fi
  exit "${exit_code}"
}

# Validates string to be one of the possible values (emulating enum data type).
# Parameters:
# 1. (Required) Param value that will be validated.
# 2. (Required) Possible values for the param value to be valid.
# 3. (Optional) Param name to display it correctly in the error message for the
#    users.
#
# Usage examples:
# fabasoad_validate_enum "true" "true,false" "my-bool-param"
# fabasoad_validate_enum "r" "r,w,rw" "permissions"
# fabasoad_validate_enum "wed" "mon,tue,wed,thu,fri,sat,sun"
fabasoad_validate_enum() {
  case ",${2}," in
    *",${1},"*)
      ;;
    *)
      msg=""
      if [ -n "${3:-""}" ]; then
        msg="${msg}\"${3}\" parameter is invalid. "
      fi
      printf "%s\"%s\" is invalid. Possible values: %s.\n" "${msg}" "${1}" "$(echo "${2}" | sed 's/,/, /g')" >&2
      _fail
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
