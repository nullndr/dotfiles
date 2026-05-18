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
  pid="$(pgrep "wf-recorder" || pgrep "slurp")"
  status=$?

  if [[ $status != 0 ]]; then 
    load_user_dirs

    output_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}"

    if [[ ! -d "$output_dir" ]]; then
      notify-send "Screen recording output directory does not exist: $output_dir" -u critical -t 3000
      exit 1
    fi

    filename="$output_dir/$(date +'recording_%Y-%m-%d-%H%M%S.mp4')"
    region="$(slurp)"

    if [[ $? -eq 0 ]]; then
      wf-recorder -g "$region" -f "$filename" &
      toggle_screenrecording
    fi
  else 
    pkill --signal SIGINT wf-recorder
    toggle_screenrecording
  fi
}

main $@
