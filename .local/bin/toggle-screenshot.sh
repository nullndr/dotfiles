#! /usr/bin/env bash

main() {
  if pgrep -x 'slurp' > /dev/null || pgrep -x 'grim' > /dev/null; then
    pkill --signal SIGINT slurp 2>/dev/null
    pkill -x grim  2>/dev/null
    return
  fi

  local action="${1:-save}"
  local target="${2:-area}"

  case "$action" in
    save) grimshot save "$target" - | swappy -f - ;;
    copy) grimshot copy "$target" ;;
    *)    echo "Usage: $0 [save|copy] [area|active|output|window]" >&2; exit 1 ;;
  esac

}

main "$@"
