#!/usr/bin/env sh
set -u

snyk_log4shell() {
  snyk_common "log4shell $@"
}
