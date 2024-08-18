#!/usr/bin/env sh

TESTS_DIR=$(dirname $(realpath "$0"))
ROOT_DIR=$(dirname "${TESTS_DIR}")
SRC_DIR="${ROOT_DIR}/src"

test_log_color_param_precedence() {
  command="$1"
  log_color_cmd="$2"
  log_color_env_var="$3"
  color_expected="$4"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  output=$(PRE_COMMIT_SNYK_LOG_COLOR="${log_color_env_var}" \
    ${SRC_DIR}/main.sh "${command}" \
    "--snyk-args=--quiet --hook-args=--log-level=debug --log-color=${log_color_cmd}" \
    2>&1 >/dev/null)

  actual=$(echo "${output}" | grep '\[22m')
  if [ -z "${actual}" ] && [ "${color_expected}" = "true" ]; then
    echo "[FAIL] ${test_name} - logs are expected to be colored"
    echo "\n${output}"
    exit 1
  elif [ -n "${actual}" ] && [ "${color_expected}" = "false" ]; then
    echo "[FAIL] ${test_name} - logs are not expected to be colored"
    echo "\n${output}"
    exit 1
  fi

  echo "[PASS] ${test_name}"
}

test_log_color_env_var() {
  command="$1"
  log_color_env_var="$2"
  color_expected="${log_color_env_var}"

  test_name="${FUNCNAME:-${0##*/}}: $@"

  output=$(PRE_COMMIT_SNYK_LOG_COLOR="${log_color_env_var}" \
    ${SRC_DIR}/main.sh "${command}" \
    "--snyk-args=--quiet --hook-args=--log-level=debug" \
    2>&1 >/dev/null)

  actual=$(echo "${output}" | grep '\[22m')
  if [ -z "${actual}" ] && [ "${color_expected}" = "true" ]; then
    echo "[FAIL] ${test_name} - logs are expected to be colored"
    echo "\n${output}"
    exit 1
  elif [ -n "${actual}" ] && [ "${color_expected}" = "false" ]; then
    echo "[FAIL] ${test_name} - logs are not expected to be colored"
    echo "\n${output}"
    exit 1
  fi

  echo "[PASS] ${test_name}"
}

main() {
  echo "Testing $(basename "$0")..."
  test_log_color_param_precedence "snyk-test" "true" "false" "true"
  test_log_color_param_precedence "snyk-test" "false" "true" "false"
  test_log_color_env_var "snyk-test" "true"
  test_log_color_env_var "snyk-test" "false"
  echo "[PASS] Total 4 tests passed\n"
}

main "$@"
