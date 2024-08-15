#!/usr/bin/env sh

apply_snyk_config() {
  snyk_version="${1:-${PRE_COMMIT_SNYK_SNYK_VERSION:-${CONFIG_SNYK_VERSION_DEFAULT_VAL}}}"
  if [ "${snyk_version}" != "latest" ]; then
    validate_semver "${CONFIG_SNYK_VERSION_ARG_NAME}" "${snyk_version}"
  fi
  export PRE_COMMIT_SNYK_SNYK_VERSION="${snyk_version}"
}
