#!/bin/bash

# Move the current window to a different display, given a direction
# Usage: ./<script_name> --north
# Usage: ./<script_name> --east
# Usage: ./<script_name> --south
# Usage: ./<script_name> --west

# What is our current focused window id?
curr_window_id="$(yabai -m query --windows --window | jq -re ".id")"

# Which direction do we move the window
direction=$1
if [ $# -gt 0 ]; then
    if [ $direction == "--north" ]; then
        $(yabai -m window --display north)
    elif [ $direction == "--west" ]; then
        $(yabai -m window --display west)
    elif [ $direction == "--south" ]; then
        $(yabai -m window --display south)
    elif [ $direction == "--east" ]; then
        $(yabai -m window --display east)
	fi
fi

# Focus the window we just moved
$(yabai -m window --focus "$curr_window_id")
