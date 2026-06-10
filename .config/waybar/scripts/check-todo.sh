#! /usr/bin/env bash

main() {
  local text=""
  local tooltip=""
  local numberOfTodos=`awk 'NF { count++ } END { print count+0 }' "$HOME/.todo/todo.txt"`

  if (( "$numberOfTodos" == 1 )); then
    local todo=$(todo.sh ls | head -n1 | sed 's/^[0-9]\+[[:space:]]*//' | cut -d' ' -f1-7)
    [[ $(wc -w <<< "$todo") -ge 7 ]] && todo+="…"

    text="<span><b>$numberOfTodos</b></span> "
    tooltip="TODO: $todo"
  elif (( "$numberOfTodos" != 0 )); then
    text="<span><b>$numberOfTodos</b></span> "
    tooltip="You have a bunch of TODOs to complete"
  fi

  jq --unbuffered -cn --arg "text" "$text" --arg "tooltip" "$tooltip" '{text:$text, tooltip:$tooltip}'
}

main "$@"

