#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

image="snyk-container-test:$(date +%s)"
for i in "$@"; do
  case $i in
    -i=*|--image=*)
      image="${i#*=}"
      ;;
    *)
      # unknown option
      ;;
  esac
done

docker build -t "${image}" .
snyk container test "${image}" "$@"
