#!/usr/bin/env bash

has_network() {
  ip link show up | grep "state UP"
}

main() {
  local data='{"text":"","tooltip":""}'
  local text
  local tooltip

  if has_network > /dev/null; then
    local updates=$(checkupdates 2> /dev/null)

    if [[ $? -eq 0 && -n "$updates" ]]; then
      local numberOfUpdates=$(echo "$updates" | wc -l)

      local tooltip=$(
        echo "$updates" | awk '
        {
          printf "<span foreground=\"#8ecae6\"><b>%s</b></span> ", $1
          printf " "
          printf "<span foreground=\"#32e47c\">%s</span>\n", $4
        }'
      )

      text="<span><b>$numberOfUpdates</b></span> "
      tooltip=$(printf "%s" "$tooltip" | jq -sR .)
    fi
  fi

  jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" '{text:$text, tooltip:$tooltip}'
}

main "$@"
