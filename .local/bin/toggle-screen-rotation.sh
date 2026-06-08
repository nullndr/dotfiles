#! /usr/bin/env bash

main() {
  local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
  local current=$(swaymsg -t get_outputs | jq -r ".[] | select(.name==\"$output\") | .transform")

  if [[ $current == "normal" ]]; then
    swaymsg output "$output" transform 180
  else
    swaymsg output "$output" transform normal
  fi

}

main "$@"
