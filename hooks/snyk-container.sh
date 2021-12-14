#!/bin/bash
set -eu
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
bash "${SCRIPT_DIR}"/_check-installation.sh

snyk_args=()
dockerfiles=()
while [[ $# -gt 0 ]]; do
  if [[ $1 == *Dockerfile ]]; then
    dockerfiles+=("$1")
  else
    snyk_args+=("$1")
  fi
done

prefix="[pre-commit-snyk]"

tag=$(date +%s)
i=1

echo $dockerfiles
echo $snyk_args

#for file_path in $dockerfiles; do
#  printf "%s %s\n" "$prefix" "$file_path"
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
#done
