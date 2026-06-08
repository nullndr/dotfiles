#!/bin/bash 

main() {
  swaynag -t warning \
    -s 'Close' \
    --button-padding 8 \
    --button-dismiss-gap 8 \
    --button-margin-right 5 \
    --button-gap 4 \
    -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' \
    -B 'Yes, exit sway' 'loginctl terminate-user $USER' \
    --debug
}

main "$@"
