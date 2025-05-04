#!/bin/bash

PROMPT="$1"

if [ -z "$PROMPT" ]; then
  echo "No prompt provided!"
  exit 1
fi

sleep 2

cd /home/superuser/Desktop/F.R.I.D.A.Y./cascade-projects/

windsurf .

sleep 90

# Press Ctrl+L
#xdotool key ctrl+l

sleep 0.01

xdotool mousemove 833 383 click 1

xdotool type "$PROMPT"

sleep 1

xdotool key Return

