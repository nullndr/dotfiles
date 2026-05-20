#!/usr/bin/env bash

main() {
  local data='{"text": "", "tooltip": ""}'

  if [[ -f /tmp/closing_uxplay ]]; then
    data='{"text": " Closing uxplay", "tooltip": "Closing uxplay"}'
    echo $data | jq --unbuffered --compact-output
    pkill -RTMIN+9 waybar
  elif pgrep -x uxplay > /dev/null; then
    data='{"text": " UxPlay", "tooltip": "Running uxplay"}'
    echo $data | jq --unbuffered --compact-output
  fi
}

main "$@"
