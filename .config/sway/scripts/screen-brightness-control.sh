#!/bin/bash 

increment() {
  brightnessctl set 5%+
}

decrement() {
  local current_value=$(brightnessctl get)
  
  if [[ "$current_value" == "4" ]]; then 
    return 0
  fi

  if [[ "$current_value" == "6000" ]]; then
    brightnessctl set 4
  else 
    brightnessctl set 5%-
  fi
}

main() {
  local WOBSOCK="$XDG_RUNTIME_DIR/wob.sock"

  if [[ -z "$1" ]]; then
    echo "Provide --increment or --decrement"
    exit 1
  fi

  case "$1" in
    "--increment")
      increment
    ;;
    "--decrement")
      decrement
    ;;
    *)
      echo "Invalid option, use only --increment or --decrement"
      exit 1
    ;;
  esac

  brightnessctl info | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK
}

main $@