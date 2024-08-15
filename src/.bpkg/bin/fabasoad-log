#!/usr/bin/env sh

FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT="text"
FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT="%Y-%m-%d %T"
FABASOAD_LOG_CONFIG_HEADER_DEFAULT="fabasoad-log"
FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT="true"
FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT="[<header>] <time> level=<level> <message>"
FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT="info"

# Text modifications

_fabasoad_wrap_text_with_color() {
  log_line="$1"
  level="$2"
  if [ "${FABASOAD_LOG_CONFIG_TEXT_COLOR:-${FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT}}" = "true" ]; then
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
  if [ "${FABASOAD_LOG_CONFIG_TEXT_COLOR:-${FABASOAD_LOG_CONFIG_TEXT_COLOR_DEFAULT}}" = "true" ]; then
    echo "\033[1m$1\033[22m"
  else
    echo "$1"
  fi
}

# Log level

_fabasoad_is_printing_error_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL:-${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}}"
  if [ "${log_level}" != "off" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_warning_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL:-${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}}"
  if [ "${log_level}" != "off" ] && [ "${log_level}" != "error" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_info_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL:-${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}}"
  if [ "${log_level}" = "debug" ] || [ "${log_level}" = "info" ]; then
    echo "true"
  else
    echo "false"
  fi
}

_fabasoad_is_printing_debug_ok() {
  log_level="${FABASOAD_LOG_CONFIG_LOG_LEVEL:-${FABASOAD_LOG_CONFIG_LOG_LEVEL_DEFAULT}}"
  if [ "${log_level}" = "debug" ]; then
    echo "true"
  else
    echo "false"
  fi
}

# Printing

_fabasoad_print_log() {
  level="$1"
  message="$2"

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
  level="$1"
  message="$2"

  text_msg="${FABASOAD_LOG_CONFIG_TEXT_FORMAT:-${FABASOAD_LOG_CONFIG_TEXT_FORMAT_DEFAULT}}"
  text_msg=${text_msg/<header>/${FABASOAD_LOG_CONFIG_HEADER:-${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}}}
  text_msg=${text_msg/<time>/$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT:-${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}}")}
  text_msg=${text_msg/<level>/$(_fabasoad_wrap_text_with_bold "${level}")}
  text_msg=${text_msg/<message>/${message}}

  text_msg=$(_fabasoad_wrap_text_with_color "${text_msg}" "${level}")
  _fabasoad_print_log "${level}" "${text_msg}"
}

_fabasoad_log_json() {
  level="$1"
  message="$2"

  json_msg="{"
  json_msg="${json_msg}\"timestamp\":\"$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT:-${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}}")\","
  json_msg="${json_msg}\"header\":\"${FABASOAD_LOG_CONFIG_HEADER:-${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}}\","
  json_msg="${json_msg}\"level\":\"${level}\","
  json_msg="${json_msg}\"message\":\"${message}\""
  json_msg="${json_msg}}"

  _fabasoad_print_log "${level}" "${json_msg}"
}

_fabasoad_log_xml() {
  level="$1"
  message="$2"

  xml_msg="<log>"
  xml_msg="${xml_msg}<timestamp>$(date +"${FABASOAD_LOG_CONFIG_DATE_FORMAT:-${FABASOAD_LOG_CONFIG_DATE_FORMAT_DEFAULT}}")</timestamp>"
  xml_msg="${xml_msg}<header>${FABASOAD_LOG_CONFIG_HEADER:-${FABASOAD_LOG_CONFIG_HEADER_DEFAULT}}</header>"
  xml_msg="${xml_msg}<level>${level}</level>"
  xml_msg="${xml_msg}<message>${message}</message>"
  xml_msg="${xml_msg}</log>"

  _fabasoad_print_log "${level}" "${xml_msg}"
}

# Public functions

fabasoad_log() {
  level="${1}"
  message="${2}"
  config_path="${3:-""}"

  if [ -f "${config_path}" ]; then
    log_init_lib="$(dirname $(realpath "${0}"))/fabasoad-log-init.sh"
    if [ -f "${log_init_lib}" ]; then
      . "${log_init_lib}"
      fabasoad_log_init "${config_path}"
    fi
  fi

  if [ "${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT:-${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT}}" = "xml" ]; then
    _fabasoad_log_xml "${level}" "${message}"
  elif [ "${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT:-${FABASOAD_LOG_CONFIG_OUTPUT_FORMAT_DEFAULT}}" = "json" ]; then
    _fabasoad_log_json "${level}" "${message}"
  else
    _fabasoad_log_text "${level}" "${message}"
  fi
}

# export
if [ ${BASH_SOURCE[0]} != $0 ]; then
  export -f fabasoad_log
else
  fabasoad_log "${@}"
  exit $?
fi
