#!/bin/bash 

toggle_uxplay() {
  pkill -RTMIN+9 waybar
}

main() {
  if pgrep -x uxplay > /dev/null; then
    pkill -x uxplay
    touch /tmp/closing_uxplay
    toggle_uxplay
    while pgrep -x uxplay > /dev/null; do
      :
    done
    rm /tmp/closing_uxplay
  else
    nohup uxplay -vsync > /dev/null 2>&1 &
    toggle_uxplay
  fi
}

main "$@"
