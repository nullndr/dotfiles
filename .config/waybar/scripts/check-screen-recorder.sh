#! /usr/bin/env bash

main() {
  local data=""

  if pgrep -x wf-recorder > /dev/null 2>&1; then
    data='{"text": "󰻂", "tooltip": "Stop recording", "class": "active"}'
  else
    data='{"text": "󰻂", "tooltip": "Start recording", "class": "idle"}'
  fi

  echo $data | jq --unbuffered --compact-output
}

main $@
