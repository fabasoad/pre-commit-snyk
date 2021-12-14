#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

prefix="[pre-commit-snyk]"

tag=$(date +%s)
i=1
# shellcheck disable=SC2044
for file_path in $@; do
  printf "%s %s\n" "$prefix" "$file_path"
#  image="pre-commit-snyk:$tag-$i"
#  if [[ $i -gt 1 ]]
#  then
#    echo ""
#  fi
#  printf "%s Building %s from %s\n\n" "$prefix" "$image" "$file_path"
#  docker build -t "$image" "$(echo "$file_path" | rev | cut -d'/' -f2- | rev)"
#  printf "\n%s Testing %s\n\n" "$prefix" "$image"
#  snyk container test "$image" "--file=$file_path" "$@"
#  printf "\n%s Removing %s\n\n" "$prefix" "$image"
#  docker rmi "$(docker images "$image" -q)" || printf "\n%s Unable to remove %s" "$prefix" "$image"
#  i=$((i + 1))
done
