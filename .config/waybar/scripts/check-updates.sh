#!/usr/bin/env bash

main() {
  updates=$(checkupdates --nocolor 2>/dev/null)
  if [[ $? -ne 0 || -z "$updates" ]]; then
    echo '{"text": "", "tooltip": ""}' | jq --unbuffered --compact-output
  else
    numberOfUpdates=$(echo "$updates" | wc -l)
    tooltip=$(echo "$updates" | sed 's/\n/\r/g' | jq -sR .)
    echo "{\"text\": \"$numberOfUpdates\", \"tooltip\": $tooltip}" | jq --unbuffered --compact-output
  fi
}

main "$@"