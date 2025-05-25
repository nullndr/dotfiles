#! /usr/bin/env bash

bat="/sys/class/power_supply/BAT1"
crit="${1:-15}"
stat="$(cat $bat/status)"
perc="$(cat $bat/capacity)"
file="$HOME/.config/waybar/scripts/lowbat"

notifysend() {
  local pid
  local title="Low Battery"
  local body="Current charge: $perc%"

  notify-send --print-id --urgency=critical --icon=dialog-warning "$title" "$body"
}

main() {
  if [[ "$stat" == "Discharging" ]] && [[ "$perc" -le "$crit" ]] && [[ ! -f "$file" ]]; then
    touch $file
    notifysend
  fi

  if [[ "$stat" == "Charging" ]] && [[ -f $file ]]; then 
    rm $file
  fi
}

main $@