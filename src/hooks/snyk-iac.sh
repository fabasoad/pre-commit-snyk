#!/usr/bin/env sh
set -u

snyk_iac() {
  snyk_common "iac test $@"
}
