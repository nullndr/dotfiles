#!/usr/bin/env bash

main() {
  local text
  local tooltip

  if [[ -f /tmp/closing_uxplay ]]; then
    text=" Closing uxplay"
    tooltip="Closing uxplay"
    jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" '{text:$text, tooltip:$tooltip}'
    pkill -RTMIN+9 waybar
  elif pgrep -x uxplay > /dev/null; then
    text=" UxPlay"
    tooltip="Running uxplay"
    jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" '{text:$text, tooltip:$tooltip}'
  fi
}

main "$@"
