#! /usr/bin/env bash

main() {
  local text
  local tooltip
  local class

  if [[ -f /tmp/closing_wfrecorder ]]; then
    text="󰻂"
    tooltip="Saving recording"
    class="saving"
    jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" --arg "class" "$class" '{text:$text, tooltip:$tooltip, class:$class}'
    pkill -RTMIN+8 waybar
  else
    text="󰻂"
    if pgrep -x wf-recorder > /dev/null 2>&1; then
      tooltip="Stop recording"
      class="active"
    else
      tooltip="Start recording"
      class="idle"
    fi
    jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" --arg "class" "$class" '{text:$text, tooltip:$tooltip, class:$class}'
  fi
}

main "$@"
