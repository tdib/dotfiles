#!/bin/bash

frontApp=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

if [ "$frontApp" == "wezterm-gui" ]; then
  osascript -e 'tell application "System Events" to set visible of application process "wezterm-gui" to false'
else
  open -a "WezTerm"
fi

