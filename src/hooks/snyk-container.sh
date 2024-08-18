#!/usr/bin/env sh
set -u

snyk_container() {
  snyk_common "container test $@"
}
