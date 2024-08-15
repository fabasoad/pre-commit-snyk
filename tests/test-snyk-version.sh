#!/usr/bin/env sh

TESTS_DIR=$(dirname $(realpath "$0"))
ROOT_DIR=$(dirname "${TESTS_DIR}")
SRC_DIR="${ROOT_DIR}/src"

test_snyk_version_param_precedence() {
  command="$1"
  snyk_version_cmd="$2"
  snyk_version_env_var="$3"
  version_expected="$4"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  if command -v snyk &> /dev/null; then
    echo "[SKIP] ${test_name} - snyk installed globally"
  else
    output=$(PRE_COMMIT_SNYK_SNYK_VERSION="${snyk_version_env_var}" \
      ${SRC_DIR}/main.sh "${command}" \
      "--snyk-args=--quiet --hook-args=--log-level=info --snyk-version=${snyk_version_cmd}" \
      2>&1 >/dev/null)

    version_actual=$(echo "${output}" | grep 'Snyk version:' | sed 's/.*Snyk version: \([0-9.]*\).*/\1/')
    if [ "${version_actual}" != "${version_expected}" ]; then
      echo "[FAIL] ${test_name} - Expected: ${version_expected}. Actual: ${version_actual}"
      echo "\n${output}"
      exit 1
    fi

    echo "[PASS] ${test_name}"
  fi
}

test_snyk_version_env_var() {
  command="$1"
  snyk_version_env_var="$2"
  version_expected="${snyk_version_env_var}"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  if command -v snyk &> /dev/null; then
    echo "[SKIP] ${test_name} - snyk installed globally"
  else
    output=$(PRE_COMMIT_SNYK_SNYK_VERSION="${snyk_version_env_var}" \
      ${SRC_DIR}/main.sh "${command}" \
      "--snyk-args=--quiet --hook-args=--log-level=info" \
      2>&1 >/dev/null)

    version_actual=$(echo "${output}" | grep 'Snyk version:' | sed 's/.*Snyk version: \([0-9.]*\).*/\1/')
    if [ "${version_actual}" != "${version_expected}" ]; then
      echo "[FAIL] ${test_name} - Expected: ${version_expected}. Actual: ${version_actual}"
      echo "\n${output}"
      exit 1
    fi

    echo "[PASS] ${test_name}"
  fi
}

main() {
  echo "Testing $(basename "$0")..."
  test_snyk_version_param_precedence "snyk-test" "0.79.2" "0.79.3" "0.79.2"
  test_snyk_version_param_precedence "snyk-test" "0.79.3" "0.79.2" "0.79.3"
  test_snyk_version_env_var "snyk-test" "0.79.2"
  echo "[PASS] Total 3 tests passed\n"
}

main "$@"
