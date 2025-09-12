#!/usr/bin/env bash

FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT="text"
FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT="%Y-%m-%d %T"
FABASOAD_LOG_CONFIG_HEADER_DEFAULT="fabasoad-log"
FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT="true"
FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT="[<header>] <timestamp> level=<level> <message>"
FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT="info"

# Initialization

_get_from_config_or_default() {
  jq -r --arg p "${1}" --arg d "${3}" 'try .config[$p] catch $d' "${2}"
}

_fabasoad_log_init() {
  header="${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}"
  output_format="${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT}"
  text_format="${FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT}"
  date_format="${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}"
  text_color="${FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT}"
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}"

  config_path="${1}"

  if [ -f "${config_path}" ]; then
    header=$(_get_from_config_or_default "header" "${config_path}" "${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}")
    tmp=$(_get_from_config_or_default "output-format" "${config_path}" "${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT}")
    case "${tmp}" in
      json|xml|text)
        output_format="${tmp}"
        ;;
    esac
    text_format=$(_get_from_config_or_default "text-format" "${config_path}" "${FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT}")
    date_format=$(_get_from_config_or_default "date-format" "${config_path}" "${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}")
    tmp=$(_get_from_config_or_default "text-color" "${config_path}" "${FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT}")
    case "${tmp}" in
      true|false)
        text_color="${tmp}"
        ;;
    esac
    tmp=$(_get_from_config_or_default "log-level" "${config_path}" "${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}")
    case "${tmp}" in
      error|warning|info|debug|off)
        log_level="${tmp}"
        ;;
    esac
  fi

  export FABASOAD_LOG_CONFIG_HEADER="${header:-${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}}"
  export FABASOAD_LOG_CONFIG_OUTPUT_FORMAT="${output_format:-${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT}}"
  export FABASOAD_LOG_CONFIG_TEXT_FORMAT="${text_format:-${FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT}}"
  export FABASOAD_LOG_CONFIG_DATE_FORMAT="${date_format:-${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}}"
  export FABASOAD_LOG_CONFIG_TEXT_COLOR="${text_color:-${FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT}}"
  export FABASOAD_LOG_CONFIG_LOG_LEVEL="${log_level:-${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}}"
}

# Text modifications

_fabasoad_wrap_text_with_color() {
  log_line="${1}"
  level="${2}"
  if [ "${FABASOAD_LOG_CONFIG_TEXT_COLOR}" = "true" ]; then
    if [ "${level}" = "error" ]; then
      printf "\033[91m${log_line}\033[0m"
    elif [ "${level}" = "warning" ]; then
      printf "\033[93m${log_line}\033[0m"
    elif [  "${level}" = "info"  ]; then
      printf "${log_line}"
    else
      printf "\033[90m${log_line}\033[0m"
    fi
  else
    printf "${log_line}"
  fi
}

_fabasoad_wrap_text_with_bold() {
  if [ "${FABASOAD_LOG_CONFIG_TEXT_COLOR}" = "true" ]; then
    echo "\033[1m${1}\033[22m"
  else
    echo "${1}"
  fi
}

# Log level

_fabasoad_is_printing_error_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL}"
  if [ "${log_level}" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_warning_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL}"
  if [ "${log_level}" != "off" ] && [ "${log_level}" != "error" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_info_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL}"
  if [ "${log_level}" = "debug" ] || [ "${log_level}" = "info" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_debug_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL}"
  if [ "${log_level}" = "debug" ]; then
    echo "true"
  else
    echo "false"
  fi
}

# Printing

_fabasoad_print_log() {
  level="${1}"
  message="${2}"

  if [ "${level}" = "error" ] && [ "$(_fabasoad_is_printing_error_ok)" = "true" ]; then # error
    printf "${message}\n" >&2
  elif [ "${level}" = "warning" ] && [ "$(_fabasoad_is_printing_warning_ok)" = "true" ]; then # warning
    printf "${message}\n" >&2
  elif [ "${level}" = "info" ] && [ "$(_fabasoad_is_printing_info_ok)" = "true" ]; then # info
    printf "${message}\n" >&2
  elif [ "${level}" = "debug" ] && [ "$(_fabasoad_is_printing_debug_ok)" = "true" ]; then # debug
    printf "${message}\n" >&2
  fi
}

_fabasoad_log_text() {
  level="${1}"
  message="${2}"

  text_msg="${FABASOAD_LOG_CONFIG_TEXT_FORMAT}"
  text_msg=${text_msg/<header>/${FABASOAD_LOG_CONFIG_HEADER}}
  text_msg=${text_msg/<timestamp>/$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT}")}
  text_msg=${text_msg/<level>/$(_fabasoad_wrap_text_with_bold "${level}")}
  text_msg=${text_msg/<message>/${message}}

  text_msg=$(_fabasoad_wrap_text_with_color "${text_msg}" "${level}")
  _fabasoad_print_log "${level}" "${text_msg}"
}

_fabasoad_log_json() {
  json_msg=$(jq -cn \
    --arg timestamp "$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT}")" \
    --arg header "${FABASOAD_LOG_CONFIG_HEADER}" \
    --arg level "${1}" \
    --arg message "${2}" \
    '{
      timestamp: $timestamp,
      header: $header,
      level: $level,
      message: $message
    }')

  _fabasoad_print_log "${level}" "${json_msg}"
}

_fabasoad_log_xml() {
  level="${1}"
  message="${2}"

  xml_msg="<log>"
  xml_msg="${xml_msg}<timestamp>$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT}")</timestamp>"
  xml_msg="${xml_msg}<header>${FABASOAD_LOG_CONFIG_HEADER}</header>"
  xml_msg="${xml_msg}<level>${level}</level>"
  xml_msg="${xml_msg}<message>${message}</message>"
  xml_msg="${xml_msg}</log>"

  _fabasoad_print_log "${level}" "${xml_msg}"
}

# Public functions

# Prints log line.
# Parameters:
# 1. (Required) Log level. Possible values: debug, info, warning, error, off.
# 2. (Required) Log message.
# 2. (Optional) Path to the config file.
#
# Usage example:
# fabasoad_log "error" "This is error message"
# fabasoad_log "debug" "This is debug message" "./config.json"
fabasoad_log() {
  _fabasoad_log_init "${3:-""}"
  _fabasoad_log_${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT} "${1}" "${2}"
}

# export
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f fabasoad_log
else
  fabasoad_log "${@}"
  exit $?
fi
