#!/usr/bin/env sh

apply_cache_config() {
  clean_cache="${1:-${PRE_COMMIT_SNYK_CLEAN_CACHE:-${CONFIG_CLEAN_CACHE_DEFAULT_VAL}}}"
  validate_enum "${clean_cache}" "${CONFIG_CLEAN_CACHE_OPTIONS}" "${CONFIG_CLEAN_CACHE_ARG_NAME}"
  export PRE_COMMIT_SNYK_CLEAN_CACHE="${clean_cache}"
}
