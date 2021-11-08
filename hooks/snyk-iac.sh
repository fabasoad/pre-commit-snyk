#!/bin/bash
set -eu
snyk iac test "$@"
