#!/bin/bash 

main() {
  pid="$(pgrep "wf-recorder" || pgrep "slurp")"
  status=$?

  if [[ $status != 0 ]]; then 
    GEO="$(slurp)" &&  wf-recorder -g "$GEO" -f "$HOME/Videos/$(date +'recording_%Y-%m-%d-%H%M%S.mp4')"
  else 
    pkill --signal SIGINT wf-recorder
  fi
}

main $@