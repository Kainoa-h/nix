#!/usr/bin/env bash


layer=${1-}

if [ -n "$layer" ]; then
  source "$HOME/.config/sketchybar/plugins/colors.sh"

  bg=""
  case "$layer" in
    "main")
      bg=$BACKGROUND_DARK
      ;;
    "symb")
      bg=$BACKGROUND_DARK_ORANGE
      ;;
    "symb^")
      bg=$BACKGROUND_DARK_BLUE
      ;;
    "aux")
      bg=$BACKGROUND_DARK_GREEN
      ;;
    "fnc")
      bg=$BACKGROUND_DARK_RED
      ;;
    "normal")
      bg=$TEXT_RED
      ;;
    *)
      bg=$BACKGROUND_DARK
      ;;
  esac

  /etc/profiles/per-user/kai/bin/sketchybar --set kan drawing=on label="$1" icon.color="$TEXT_WHITE" label.color="$TEXT_WHITE" background.color="$bg"
else
  /etc/profiles/per-user/kai/bin/sketchybar --set kan drawing=off
fi


