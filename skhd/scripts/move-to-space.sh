#!/bin/bash

# Move the current window to a given space 1-10
# Usage: ./<script_name> 1
# Usage: ./<script_name> 2
# Usage: ./<script_name> 3
# Usage: ./<script_name> ...

# Which space/desktop do we want to target
screen_number=$1

# Which window are we moving?
curr_window_id="$(yabai -m query --windows --window | jq -re ".id")"

# Move the window to the target space
$(yabai -m window --space $screen_number)

# Move to the target space
$(yabai -m window --focus "$curr_window_id")
