#! /usr/bin/env bash

main() {
  local text="󰣇"
  local tooltip=`uname -r`
  jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" --arg "class" "$class" '{text:$text, tooltip:$tooltip, class:$class}'
}

main "$@"
