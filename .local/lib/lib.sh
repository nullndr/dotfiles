#!/usr/bin/env bash

set -euo pipefail

get_compositor() {
  if [[ -n "${SWAYSOCK:-}" ]]; then
    echo "sway"
  elif [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    echo "hyprland"
  else
    echo "unknown"
  fi
}

is_sway() {
  [[ "$(get_compositor)" == "sway" ]]
}

is_hyprland() {
  [[ "$(get_compositor)" == "hyprland" ]]
}