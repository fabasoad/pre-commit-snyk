#!/usr/bin/env sh

_run_validator() {
  func_name="${1}"
  shift

  set +e
  err_msg=$(${func_name} "$@" 2>&1 >/dev/null)
  exit_code=$?
  if [ "${exit_code}" -ne 0 ]; then
    fabasoad_log "error" "${err_msg}"
    exit ${exit_code}
  fi
  set -e
}

validate_enum() {
  _run_validator "fabasoad_validate_enum" "$@"
}

validate_semver() {
  _run_validator "fabasoad_validate_semver" "$@"
}

validate_tool_installed() {
  _run_validator "fabasoad_validate_tool_installed" "$@"
}
