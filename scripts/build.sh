#!/usr/bin/env sh

SCRIPTS_DIR=$(dirname $(realpath "$0"))
ROOT_DIR="$(dirname "${SCRIPTS_DIR}")"

bpkg_packages_dir="${ROOT_DIR}/src/.bpkg"

main() {
  mkdir -p "${bpkg_packages_dir}"
  lock_file="${ROOT_DIR}/.bpkg.lock"
  while IFS= read -r line; do
    PREFIX="${bpkg_packages_dir}" bpkg install "$line"
  done < "${lock_file}"
}

main "$@"
