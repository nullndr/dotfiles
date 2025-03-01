#! /usr/bin/env bash

file=~/.config/waybar/scripts/lowbat
bat="/sys/class/power_supply/BAT1"
crit="${1:-150}"
stat="$(cat $bat/status)"
perc="$(cat $bat/capacity)"

notifysend() {
  local pid
  local title="Low Battery"
  local body="Current charge: $perc%"
  if [[ ! -f "$file" ]]; then
    pid="$(notify-send --print-id --urgency=critical --icon=dialog-warning "$title" "$body")"
  else
    pid="$(notify-send --print-id --replace-id="$(cat $file)" --urgency=critical --icon=dialog-warning "$title" "$body")"
  fi

  echo $pid > $file
}

main() {
  if [[ "$stat" == "Discharging" ]] && [[ "$perc" -le "$crit" ]] && [[ ! -f "$file" ]]; then
    notifysend
  fi

  if [[ -f "$file" ]]; then
    case "$stat" in
      "Charging" ) 
        rm $file
      ;;
      "Discharging" )
        notifysend
      ;;
      * );;
    esac

  fi
}

main $@