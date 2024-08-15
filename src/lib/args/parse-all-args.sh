#!/usr/bin/env bash

parse_all_args() {
  local -n args_map_ref=$1
  shift

  args_map_ref["snyk-args"]=""
  args_map_ref["hook-args"]=""

  curr_flag=""

  args="$@"

  # Loop through all the arguments
  while [[ -n "${args}" ]]; do
    case "$(echo "${args}" | cut -d '=' -f 1)" in
      --hook-args)
        args=$(echo "${args#*=}" | sed 's/^ *//')
        curr_flag="hook"
        ;;
      --snyk-args)
        args=$(echo "${args#*=}" | sed 's/^ *//')
        curr_flag="snyk"
        ;;
      *)
        arg=$(echo "${args}" | cut -d ' ' -f 1)
        if [ "${curr_flag}" = "hook" ]; then
          args_map_ref["hook-args"]="${args_map_ref["hook-args"]} ${arg}"
        elif [ "${curr_flag}" = "snyk" ]; then
          args_map_ref["snyk-args"]="${args_map_ref["snyk-args"]} ${arg}"
        else
          msg="Invalid format of the following argument: \"${arg}\". Please use"
          msg="${msg} --hook-args to pass args to pre-commit hook or --snyk-args"
          msg="${msg} to pass args to snyk. For more information see https://github.com/fabasoad/pre-commit-snyk?tab=readme-ov-file"
          fabasoad_log "error" "${msg}"
          exit 1
        fi

        args=$(echo "${args}" | cut -d ' ' -f 2- | sed 's/^ *//')
        if [ "${arg}" = "${args}" ]; then
          args=""
        fi
        ;;
    esac
  done

  # Removing leading space is needed here because we concatenate string in a loop
  # and we start with a empty string. So, first iteration is empty string + space
  # + next value. Here we remove that empty string from the beginning
  args_map_ref["hook-args"]=$(echo "${args_map_ref["hook-args"]}" | sed 's/^ *//')
  args_map_ref["snyk-args"]=$(echo "${args_map_ref["snyk-args"]}" | sed 's/^ *//')
}
