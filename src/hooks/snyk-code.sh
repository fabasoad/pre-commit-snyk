#!/usr/bin/env sh
set -u

snyk_code() {
  snyk_common "code test $@"
}
