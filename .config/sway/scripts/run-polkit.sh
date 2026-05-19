#!/bin/bash 

main() {
  pgrep -x lxqt-policykit-agent > /dev/null && exit 0
  nohup lxqt-policykit-agent > /dev/null 2>&1 &
}

main "$@"