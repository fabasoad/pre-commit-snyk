#!/usr/bin/env sh
set -u

snyk_test() {
  snyk_common "test $@"
}
