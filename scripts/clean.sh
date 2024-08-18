#!/usr/bin/env sh

SCRIPTS_DIR=$(dirname $(realpath "$0"))
ROOT_DIR="$(dirname "${SCRIPTS_DIR}")"

bpkg_packages_dir="${ROOT_DIR}/src/.bpkg"

main() {
  rm -rf "${bpkg_packages_dir}"
}

main "$@"
