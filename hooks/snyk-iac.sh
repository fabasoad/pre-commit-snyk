#!/bin/bash
set -eu
snyk iac test "$1"
