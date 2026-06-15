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
      sleep 0.1
    done
    rm /tmp/closing_uxplay
  else
    nohup env \
      WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
      XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
      SDL_VIDEODRIVER=wayland \
      uxplay -vsync > /dev/null 2>&1 &
    toggle_uxplay
  fi
}

main "$@"
