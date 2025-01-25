#!/usr/bin/env bash

PRE_COMMIT_SNYK_SRC_DIR=$(dirname $(realpath "$0"))

# Import all scripts
_import_all() {
  current_file=$(realpath "$0")
  exec_files=$(find "${PRE_COMMIT_SNYK_SRC_DIR}" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \))
  for file in $exec_files; do
    if [ "${file}" != "${current_file}" ]; then
      . "${file}"
    fi
  done
}

# Validate that all needed dependencies are installed on the machine
_validate_prerequisites() {
  validate_tool_installed "jq"
  validate_tool_installed "curl"
}

main() {
  _import_all
  _validate_prerequisites

  cmd_snyk_code="snyk-code"
  cmd_snyk_container="snyk-container"
  cmd_snyk_iac="snyk-iac"
  cmd_snyk_log4shell="snyk-log4shell"
  cmd_snyk_test="snyk-test"

  cmd_actual="${1}"
  shift

  declare -A all_args_map
  parse_all_args all_args_map "$(echo "$@" | sed 's/^ *//' | sed 's/ *$//')"
  declare -A hook_args_map
  parse_hook_args hook_args_map "${all_args_map["hook-args"]}"

  # Apply configs
  set +u
  apply_logging_config \
    "${hook_args_map["${CONFIG_LOG_LEVEL_ARG_NAME}"]}" \
    "${hook_args_map["${CONFIG_LOG_COLOR_ARG_NAME}"]}"
  apply_cache_config "${hook_args_map["${CONFIG_CLEAN_CACHE_ARG_NAME}"]}"
  apply_snyk_config "${hook_args_map["${CONFIG_SNYK_VERSION_ARG_NAME}"]}"

  if [ "${#hook_args_map[@]}" -ne 0 ]; then
    fabasoad_log "info" "Pre-commit hook arguments: $(map_to_str hook_args_map)"
  fi
  set -u

  case "${cmd_actual}" in
    "${cmd_snyk_code}")
      snyk_code "${all_args_map["snyk-args"]}"
      ;;
    "${cmd_snyk_container}")
      snyk_container "${all_args_map["snyk-args"]}"
      ;;
    "${cmd_snyk_iac}")
      snyk_iac "${all_args_map["snyk-args"]}"
      ;;
    "${cmd_snyk_log4shell}")
      snyk_log4shell "${all_args_map["snyk-args"]}"
      ;;
    "${cmd_snyk_test}")
      snyk_test "${all_args_map["snyk-args"]}"
      ;;
    *)
      validate_enum "${cmd_actual}" "${cmd_snyk_code},${cmd_snyk_container},${cmd_snyk_iac},${cmd_snyk_log4shell},${cmd_snyk_test}"
      ;;
  esac
}

main "$@"
