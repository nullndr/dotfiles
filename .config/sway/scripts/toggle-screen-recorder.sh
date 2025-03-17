#!/bin/bash 

main() {
  local pid="$(pgrep "wf-recorder" || pgrep "slurp")"

  if [[ $? != 0 ]]; then 
    GEO="$(slurp)" &&  wf-recorder -g "$GEO" -f "$HOME/Pictures/$(date +'recording_%Y-%m-%d-%H%M%S.mp4')"
  else 
    pkill --signal SIGINT wf-recorder
  fi
}

main