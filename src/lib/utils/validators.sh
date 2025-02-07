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

validate_bash_version() {
  minimum_required_major_version=4
  bash_version=$(bash --version | head -n 1 | cut -d ' ' -f 4)
  bash_major=$(echo "${bash_version}" | cut -d '.' -f 1)
  if [ "${bash_major}" -lt "${minimum_required_major_version}" ]; then
    msg="bash version ${minimum_required_major_version}.0 or higher is required."
    msg="${msg} Current version is ${bash_version}."
    fabasoad_log "error" "${msg}"
    exit 1
  fi
}
