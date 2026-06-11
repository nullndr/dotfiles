#! /usr/bin/env bash

get_compositor() {
  if [[ -n "$SWAYSOCK" ]]; then
    echo "sway"
  elif [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
    echo "hyprland"
  else
    echo "unknown"
  fi
}

rotate_sway() {
  local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
  local current=$(swaymsg -t get_outputs | jq -r ".[] | select(.name==\"$output\") | .transform")

  if [[ $current == "normal" ]]; then
    swaymsg output "$output" transform 180
  else
    swaymsg output "$output" transform normal
  fi
}

rotate_hyprland() {
  local output=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
  local current=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$output\") | .transform")

  if [[ $current -eq 0 ]]; then
    hyprctl eval "hl.monitor({ output = \"eDP-1\", mode = \"1920x1080\", position = \"0x0\", scale = 1, transform = 2 })"
  else
    hyprctl eval "hl.monitor({ output = \"$output\", mode = \"1920x1080\", position = \"0x0\", scale = 1, transform = 0 })"
  fi
}

main() {
  case "$(get_compositor)" in
    sway)      rotate_sway ;;
    hyprland)  rotate_hyprland ;;
    *)         echo "Compositor non supportato" >&2; exit 1 ;;
  esac
}

main "$@"
