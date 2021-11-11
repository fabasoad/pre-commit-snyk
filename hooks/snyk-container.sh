#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

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

if [ -z "${image:-}" ]
then
  image="snyk-container-test:$(date +%s)"
  docker build -t "${image}" .
fi

snyk container test "${image}" "$@"
