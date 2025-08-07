#!/usr/bin/env bash

main() {
  data=""
  updates=$(checkupdates --nocolor 2>/dev/null)

  if [[ $? -ne 0 || -z "$updates" ]]; then
    data='{"text": "", "tooltip": ""}'
  else
    numberOfUpdates=$(echo "$updates" | wc -l)
    tooltip=$(echo "$updates" | sed 's/\n/\r/g' | jq -sR .)
    data="{\"text\": \"$numberOfUpdates\", \"tooltip\": $tooltip}" 
  fi

  echo $data | jq --unbuffered --compact-output
}

main "$@"
