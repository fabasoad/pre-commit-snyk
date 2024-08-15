#!/usr/bin/env sh

map_to_str() {
  local -n map_ref=$1
  shift

  args_delimiter="${1:-" "}"
  key_val_delimiter="${2:-"="}"

  str=""
  if [ "${#map_ref[@]}" -ne 0 ]; then
    for key in "${!map_ref[@]}"; do
      str="${str}${args_delimiter}${key}${key_val_delimiter}${map_ref[$key]}"
    done
  fi
  if [ "${#str}" -ne 0 ]; then
    str=${str:${#args_delimiter}}
  fi
  echo "${str}"
}
