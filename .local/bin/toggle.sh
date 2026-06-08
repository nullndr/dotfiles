#!/bin/bash

notifysend() {
  if [[ "$1" != "" ]]; then
    notify-send -u low "$disabled_notification"
  fi
}

main() {
  local enabled_notification=""
  local disabled_notification=""

  while [[ $# -gt 1 ]]; do
    case $1 in
      --enabled-notification)
        enabled_notification="$2"
        shift 2
      ;;
      --disabled-notification)
        disabled_notification="$2"
        shift 2
      ;;
      *) 
        break
      ;;
    esac
  done

  local flag_path="$HOME/.local/state/toggles/$1"

  if [[ -f $flag_path ]]; then
    rm $flag_path
    notifysend "$disabled_notification"
  else
    mkdir -p "$(dirname $flag_path)"
    touch $flag_path
    notifysend "$enabled_notification"
  fi
}

main "$@"