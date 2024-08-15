#!/usr/bin/env sh

_download() {
  target_path="${1}"
  version="${2}"

  # Add "v" prefix if it is not "latest"
  if [ "${version}" != "latest" ]; then
    version="v${version}"
  fi

  # Determine correct binary based on OS
  if [ -f "/etc/alpine-release" ]; then
    binary="snyk-alpine"
  else
    case "$(uname -s)" in
      Darwin*)
        binary="snyk-macos"
        ;;
      MINGW64*)
        binary="snyk-win.exe"
        ;;
      MSYS_NT*)
        binary="snyk-win.exe"
        ;;
      *)
        if [ "$(uname -m)" = "arm64" ]; then
          binary="snyk-linux-arm64"
        else
          binary="snyk-linux"
        fi
        ;;
    esac
  fi

  curl -sSfL "https://static.snyk.io/cli/${version}/${binary}" -o "${target_path}"
  chmod +x "${target_path}"
}

install() {
  fabasoad_log "debug" "Verifying Snyk installation"
  if command -v snyk &> /dev/null; then
    snyk_path="$(which snyk)"
    fabasoad_log "debug" "Snyk is found at ${snyk_path}. Installation skipped"
  else
    snyk_path="${CONFIG_TEMP_BIN_DIR}/snyk"
    mkdir -p "${CONFIG_TEMP_BIN_DIR}"
    if [ ! -d "${CONFIG_TEMP_BIN_DIR}" ] || [ ! -f "${snyk_path}" ]; then
      fabasoad_log "debug" "Snyk is not found. Downloading ${PRE_COMMIT_SNYK_SNYK_VERSION} version:"
      _download "${snyk_path}" "${PRE_COMMIT_SNYK_SNYK_VERSION}"
      fabasoad_log "debug" "Downloading completed"
    else
      fabasoad_log "debug" "Snyk is found at ${snyk_path}. Installation skipped"
    fi
  fi
  echo "${snyk_path}"
}
