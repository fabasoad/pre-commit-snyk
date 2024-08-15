#!/usr/bin/env sh

TESTS_DIR=$(dirname $(realpath "$0"))

main() {
  total_tests=11
  failed_tests=0

  current_file=$(realpath "$0")
  test_files=$(find "${TESTS_DIR}" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \))
  for test_file in $test_files; do
    if [ "${test_file}" != "${current_file}" ]; then
      ${test_file}
      if [ "$?" -ne 0 ]; then
        failed_tests=$((failed_tests + 1))
      fi
    fi
  done

  #perl -E 'say "-" x 45'
  echo "Total $((total_tests - failed_tests)) tests passed, ${failed_tests} tests failed."
}

main "$@"
