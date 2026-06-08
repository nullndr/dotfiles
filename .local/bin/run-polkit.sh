#!/bin/bash 

main() {
  pgrep -f xfce-polkit > /dev/null && exit 0
  nohup /usr/lib/xfce-polkit/xfce-polkit > /dev/null 2>&1 &
}

main "$@"
