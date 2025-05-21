#! /usr/bin/env bash

main() {
  pid="$(pgrep "wf-recorder" || pgrep "slurp")"
  status=$?

  if [[ $status == 0 ]]; then 
    pkill --signal SIGINT wf-recorder
  fi
}

main $@