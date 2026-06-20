#!/usr/bin/env bash

set -euo pipefail

main() {
  source "$HOME/.local/lib/lib.sh"

  local hypr_polkit_bin="/usr/lib/hyprpolkitagent/hyprpolkitagent"
  local xfce_polkit_bin="/usr/lib/xfce-polkit/xfce-polkit"

  is_running_path() {
    pgrep -u "$UID" -f "$1" > /dev/null 2>&1
  }

  start_hypr_polkit() {
    systemctl --user is-active --quiet hyprpolkitagent.service && exit 0

    if systemctl --user start hyprpolkitagent.service > /dev/null 2>&1; then
      exit 0
    fi

    if [[ -x "$hypr_polkit_bin" ]]; then
      is_running_path "$hypr_polkit_bin" && exit 0
      nohup "$hypr_polkit_bin" > /dev/null 2>&1 &
      exit 0
    fi

    echo "hyprpolkitagent not found" >&2
    exit 1
  }


  start_sway_polkit() {
    is_running_path "$xfce_polkit_bin" && exit 0

    if [ -x "$xfce_polkit_bin" ]; then
      nohup "$xfce_polkit_bin" > /dev/null 2>&1 &
      exit 0
    fi

    echo "xfce-polkit not found" >&2
    exit 1
  }

  case "$(get_compositor)" in
    sway)      start_sway_polkit ;;
    hyprland)  start_hypr_polkit ;;
    *)         echo "Compositor non supportato" >&2; exit 1 ;;
}

main "$@"