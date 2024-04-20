#!/usr/bin/env bash
set -eu

SCRIPT_PATH=$(realpath "$0")
HOOKS_FOLDER_PATH=$(dirname "${SCRIPT_PATH}")
INSTALLATION_FOLDER_PATH="${HOOKS_FOLDER_PATH}/installation"

sh "${INSTALLATION_FOLDER_PATH}/main.sh"

prefix="[pre-commit-snyk]"

container_build() {
  tag="$1"
  path="$2"
  if command -v docker &> /dev/null; then
    docker build -t "$tag" "$path"
  elif command -v podman &> /dev/null; then
    podman build -t "$tag" "$path"
  else
    echo "$prefix docker or podman are not found. Please install one of these tools and try again"
    exit 1
  fi
}

container_rmi() {
  image="$1"
  if command -v docker &> /dev/null; then
    docker rmi "$(docker images "$image" -q)" || printf "\n%s Unable to remove %s" "$prefix" "$image"
  elif command -v podman &> /dev/null; then
    podman rmi "$(podman images "$image" -q)" || printf "\n%s Unable to remove %s" "$prefix" "$image"
  else
    echo "$prefix docker or podman are not found. Please install one of these tools and try again"
    exit 1
  fi
}

snyk_args=()
dockerfiles=()
for arg in "$@"; do
  if [[ $arg == *Dockerfile ]]; then
    dockerfiles+=("$arg")
  else
    snyk_args+=("$arg")
  fi
done

tag=$(date +%s)
i=1

for file_path in "${dockerfiles[@]}"; do
  image="pre-commit-snyk:$tag-$i"
  if [ $i -gt 1 ]; then
    echo ""
  fi
  printf "%s Building %s from %s\n\n" "$prefix" "$image" "$file_path"
  container_build "$image" "$(echo "$file_path" | rev | cut -d'/' -f2- | rev)"
  printf "\n%s Testing %s\n" "$prefix" "$image"
  snyk container test "$image" "--file=$file_path" "${snyk_args[*]}"
  printf "\n%s Removing %s" "$prefix" "$image"
  container_rmi "$image"
  i=$((i + 1))
done
