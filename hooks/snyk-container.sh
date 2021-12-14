#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

prefix="[pre-commit-snyk]"
# shellcheck disable=SC2068
echo $@

tag=$(date +%s)

image="pre-commit-snyk:$tag-$((1 + RANDOM))"
printf "%s Building %s from %s\n\n" "$prefix" "$image" "$1"
docker build -t "$image" "$(echo "$1" | rev | cut -d'/' -f2- | rev)"
printf "\n%s Testing %s\n\n" "$prefix" "$image"
snyk container test "$image" "--file=$1" "$@"
printf "\n%s Removing %s\n\n" "$prefix" "$image"
docker rmi "$(docker images "$image" -q)" || printf "\n%s Unable to remove %s\n\n" "$prefix" "$image"
