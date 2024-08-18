#!/usr/bin/env sh

_remove_dir() {
  rm -rf "${1}"
  fabasoad_log "debug" "${1} directory has been removed"
}

uninstall() {
  if [ "${PRE_COMMIT_SNYK_CLEAN_CACHE}" = "true" ]; then
    if [ -d "${CONFIG_CACHE_APP_DIR}" ]; then
      _remove_dir "${CONFIG_CACHE_APP_DIR}"
    fi
    if [ -d "${CONFIG_CACHE_ROOT_DIR}" ] && [ -z "$(ls -A "${CONFIG_CACHE_ROOT_DIR}" 2>/dev/null)" ]; then
      _remove_dir "${CONFIG_CACHE_ROOT_DIR}"
    fi
  else
    if [ -d "${CONFIG_CACHE_APP_DIR}" ]; then
      fabasoad_log "debug" "${CONFIG_CACHE_APP_DIR} directory was preserved"
    fi
  fi
}
