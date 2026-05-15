#!/usr/bin/env bash

has_network() {
  ip link show up | grep "state UP"
}

main() {
  data='{"text": "", "tooltip": ""}'

  if ! has_network > /dev/null; then
    echo $data | jq --unbuffered --compact-output
    return
  fi

  updates=$(checkupdates --nocolor 2>/dev/null)

  if [[ $? -eq 0 && -n "$updates" ]]; then
    numberOfUpdates=$(echo "$updates" | wc -l)
    tooltip=$(echo "$updates" | sed 's/\n/\r/g' | jq -sR .)
    data="{\"text\": \"$numberOfUpdates \", \"tooltip\": $tooltip}" 
  fi

  echo $data | jq --unbuffered --compact-output
}

main "$@"
