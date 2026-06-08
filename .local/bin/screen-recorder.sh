#! /usr/bin/env bash

toggle_screenrecording() {
  pkill -RTMIN+8 waybar
}

load_user_dirs() {
  if [[ -f ~/.config/user-dirs.dirs ]]; then
    source ~/.config/user-dirs.dirs
  fi
}

main() {
  if pgrep -x 'wf-recorder|slurp' > /dev/null; then 
    if pgrep -x wf-recorder; then
      pkill --signal SIGINT wf-recorder
      touch /tmp/closing_wfrecorder
      toggle_screenrecording
      while pgrep -x wf-recorder  > /dev/null; do
        :
      done
      rm /tmp/closing_wfrecorder
    else
      pkill --signal SIGINT slurp 
    fi
  else 
    load_user_dirs

    output_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}"

    if [[ ! -d "$output_dir" ]]; then
      notify-send -u critical -t 5000 "Screen recording output directory does not exist: $output_dir"
      exit 1
    fi

    filename="$output_dir/$(date +'recording_%Y-%m-%d-%H%M%S.mp4')"
    region="$(slurp)"

    if [[ $? -eq 0 ]]; then
      wf-recorder -g "$region" -f "$filename" &
      toggle_screenrecording
    fi
  fi
}

main "$@"
