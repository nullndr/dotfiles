#!/bin/bash

main() {
  local WOBSOCK="$XDG_RUNTIME_DIR/wob.sock"
  local name="$1"
  local action="$2"

  case "$action" in
    increment|decrement)
      local update="1%+"

      if [[ "$action" == "decrement" ]]; then
        update="1%-"
      fi

      wpctl set-volume $name $update
      wpctl get-volume $name | awk '{print $2 * 100}' > $WOBSOCK
    ;;
    toggle)
      wpctl set-mute $name toggle
    ;;
  esac
}

main "$@"
