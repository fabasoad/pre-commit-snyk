#!/usr/bin/env sh

fabasoad_log_init() {
  header="[fabasoad-log]"
  output_format="text"
  text_format="[<header>] <time> level=<level> <message>"
  date_format="%Y-%m-%d %T"
  text_color="true"
  log_level="info"

  config_path="$1"

  if [ -f "${config_path}" ]; then
    header=$(jq -r --arg var1 "${header}" 'try .config.header catch $var1' "${config_path}")
    output_format_temp=$(jq -r --arg var1 "${output_format}" 'try .config["output-format"] catch $var1' "${config_path}")
    if [ "${output_format_temp}" = "json" ] || [ "${output_format_temp}" = "xml" ] || [ "${output_format_temp}" = "text" ]; then
      output_format="${output_format_temp}"
    fi
    text_format=$(jq -r --arg var1 "${text_format}" 'try .config["text-format"] catch $var1' "${config_path}")
    date_format=$(jq -r --arg var1 "${date_format}" 'try .config["date-format"] catch $var1' "${config_path}")
    text_color_temp=$(jq -r --arg var1 "${text_color}" 'try .config["text-color"] catch $var1' "${config_path}")
    if [ "${text_color_temp}" = "true" ] || [ "${text_color_temp}" = "false" ]; then
      text_color="${text_color_temp}"
    fi
    log_level_temp=$(jq -r --arg var1 "${log_level}" 'try .config["log-level"] catch $var1' "${config_path}")
    if [ "${log_level_temp}" = "error" ] \
      || [ "${log_level_temp}" = "warning" ] \
      || [ "${log_level_temp}" = "info" ] \
      || [ "${log_level_temp}" = "debug" ] \
      || [ "${log_level_temp}" = "off" ]; then
      log_level="${log_level_temp}"
    fi
  fi

  if [ -n "${header}" ]; then
    export FABASOAD_LOG_CONFIG_HEADER="${header}"
  fi

  if [ -n "${output_format}" ]; then
    export FABASOAD_LOG_CONFIG_OUTPUT_FORMAT="${output_format}"
  fi

  if [ -n "${text_format}" ]; then
    export FABASOAD_LOG_CONFIG_TEXT_FORMAT="${text_format}"
  fi

  if [ -n "${date_format}" ]; then
    export FABASOAD_LOG_CONFIG_DATE_FORMAT="${date_format}"
  fi

  if [ -n "${text_color}" ]; then
    export FABASOAD_LOG_CONFIG_TEXT_COLOR="${text_color}"
  fi

  if [ -n "${log_level}" ]; then
    export FABASOAD_LOG_CONFIG_LOG_LEVEL="${log_level}"
  fi
}

# export
if [ ${BASH_SOURCE[0]} != $0 ]; then
  export -f fabasoad_log_init
else
  fabasoad_log_init "${@}"
  exit $?
fi
