#!/usr/bin/env bash

main() {
  data='{"text": "", "tooltip": ""}'

  if [[ -f /tmp/closing_uxplay ]]; then
    data='{"text": " Closing airplay", "tooltip": "Closing airplay"}'
    echo $data | jq --unbuffered --compact-output
    pkill -RTMIN+9 waybar
  elif pgrep -x uxplay > /dev/null; then
    data='{"text": " Airplay", "tooltip": "Running airplay"}'
    echo $data | jq --unbuffered --compact-output
  fi
}

main "$@"
