#!/usr/bin/env sh

parse_hook_args() {
  local -n args_map_ref=$1
  shift

  args_str="${1}"
  if [ -n "${args_str}" ]; then
    orig_str="${args_str}"
    while [ ${#args_str} -gt 0 ]; do
      delimiter=""
      case "${args_str}" in
        "${CONFIG_LOG_LEVEL_ARG_NAME}="*|"${CONFIG_LOG_COLOR_ARG_NAME}="*|"${CONFIG_SNYK_VERSION_ARG_NAME}="*|"${CONFIG_CLEAN_CACHE_ARG_NAME}="*)
          delimiter="="
          ;;
        "${CONFIG_LOG_LEVEL_ARG_NAME} "*|"${CONFIG_LOG_COLOR_ARG_NAME} "*|"${CONFIG_SNYK_VERSION_ARG_NAME} "*|"${CONFIG_CLEAN_CACHE_ARG_NAME} "*)
          delimiter=" "
          ;;
        *)
          fabasoad_log "error" "Unknown \"${args_str}\" argument has been passed to --hook-args"
          exit 1
          ;;
      esac

      # Removing param key, such as "--log-level"
      param_key=$(echo "${args_str}" | cut -d "${delimiter}" -f 1)
      args_str=$(echo "${args_str}" | cut -d "${delimiter}" -f 2-)
      # Taking param value, such as "debug"
      param_val=$(echo "${args_str}" | cut -d ' ' -f 1)
      # Saving leftover
      args_str=$(echo "${args_str}" | cut -d ' ' -f 2-)
      # If leftover is the same as prev. value then it was the last argument in
      # the string, so we finish loop
      if [ "${param_val}" = "${args_str}" ]; then
        args_str=""
      fi
      # Saving parameter to the map
      args_map_ref["${param_key}"]="${param_val}"
    done
  fi
}
