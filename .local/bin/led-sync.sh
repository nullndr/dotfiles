#!/bin/sh

main () {
  get_sink_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0
  }

  get_source_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0
  }

  update() {
    echo "$(get_sink_muted)" > "/sys/class/leds/platform::mute/brightness"
    echo "$(get_source_muted)" > "/sys/class/leds/platform::micmute/brightness"
  }

  update

  pw-mon | while read -r line; do
    case "$line" in
      *key*mute*)
        update
        ;;
    esac
  done
}

main "$@"
