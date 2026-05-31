#! /usr/bin/env bash

main() {
  local text=""
  local tooltip=""

  if systemctl is-active --quiet cups; then
    text="󰐪"
    tooltip="Running CUPS"
  fi

  jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" '{text:$text, tooltip:$tooltip}'
}

main "$@"
