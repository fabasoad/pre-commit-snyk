#!/usr/bin/env sh
set -u

snyk_common() {
  # Removing trailing space (sed command) is needed here in case there were no
  # --snyk-args passed, so for example, $1 in this case is "test "
  snyk_args="$(echo "$1" | sed 's/ *$//')"

  snyk_path=$(install)
  snyk_version=$(${snyk_path} --version | cut -d ' ' -f 2)
  fabasoad_log "info" "Snyk path: ${snyk_path}"
  fabasoad_log "info" "Snyk version: ${snyk_version}"
  fabasoad_log "info" "Snyk arguments: ${snyk_args}"

  fabasoad_log "debug" "Run Snyk scanning:"
  set +e
  ${snyk_path} ${snyk_args}
  snyk_exit_code=$?
  set -e
  fabasoad_log "debug" "Snyk scanning completed"
  msg="Snyk exit code: ${snyk_exit_code}"
  if [ "${snyk_exit_code}" = "0" ]; then
    fabasoad_log "info" "${msg}"
  else
    fabasoad_log "warning" "${msg}"
  fi

  uninstall "${CONFIG_TEMP_DIR}"
  exit ${snyk_exit_code}
}
