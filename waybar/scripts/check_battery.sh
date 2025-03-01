#! /usr/bin/env bash

FILE=~/.config/waybar/scripts/.low_bat

bat="/sys/class/power_supply/BAT1"
CRIT="${1:-15}"
stat="$(cat $bat/status)"
perc="$(cat $bat/capacity)"

if [[ $perc -le $CRIT ]] && [[ "$stat" == "Discharging" ]] && [[ ! -f "$FILE" ]]; then
  notify-send --urgency=critical --icon=dialog-warning "Battery Low" "Current charge: $perc%"
  touch $FILE
fi

if [[ -f "$FILE" ]] && [[ "$stat" == "Charging" ]]; then
  rm $FILE
fi