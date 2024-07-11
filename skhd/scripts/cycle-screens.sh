#!/bin/bash

# Move the current window to the next/previous screen.
# Usage: ./<script_name> --next
# Usage: ./<script_name> --prev

# Determine if we want to target the next or previous screen
# The previous screen can be targeted using "--prev" as the first argument in the command
direction_right=true
if [ $# -gt 0 ] && [ "$1" == "--prev" ]; then
    direction_right=false
fi

# What is our current focused window id?
curr_window_id="$(yabai -m query --windows --window | jq -re ".id")"

if $direction_right ; then
    # Move to window to the left
    $(yabai -m window --display prev || yabai -m window --display first)
else
    # Move to window to the right
    $(yabai -m window --display prev || yabai -m window --display last)
fi

# Focus the window we just moved
$(yabai -m window --focus "$curr_window_id")
