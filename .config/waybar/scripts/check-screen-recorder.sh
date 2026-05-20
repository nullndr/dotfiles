#! /usr/bin/env bash

main() {
  local data=""

  if [[ -f /tmp/closing_wfrecorder ]]; then
    data='{"text": "󰻂", "tooltip": "Saving recording", "class": "saving"}'
    echo $data | jq --unbuffered --compact-output
    pkill -RTMIN+8 waybar
  else
    if pgrep -x wf-recorder > /dev/null 2>&1; then
      data='{"text": "󰻂", "tooltip": "Stop recording", "class": "active"}'
    else
      data='{"text": "󰻂", "tooltip": "Start recording", "class": "idle"}'
    fi
    echo $data | jq --unbuffered --compact-output
  fi
}

main "$@"
