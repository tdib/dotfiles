
# Where is AOC located
AOC_HOME="$HOME/dev/advent-of-code"

# Will go to the specified year's directory
# Usage: aoc <year>
function aoc() {
    if [ "$#" -ne 1 ]; then
        cd "$AOC_HOME"
    else
        cd "$AOC_HOME/$1"
    fi
}

# Will create a new directory for the specified day and fill
# it with a template python file, or open the directory if it
# already exists
# Usage: day <day number> - assumes the user is in the target year's directory
# Usage: day <day number> <year number> - will go to the specified year's directory
function day() {
    # Check if user is in AOC folder
    current_dir=$(pwd)
    if [[ $current_dir =~ ^$AOC_HOME/[0-9]{4}$ ]]; then
        in_year_subdir=true
    else
        in_year_subdir=false
    fi

    # We have provided two args - we will go to the
    # specified dir no matter what
    if [ "$#" -eq 2 ]; then
        if [ -d "$AOC_HOME/$2" ]; then
            cd "$AOC_HOME/$2"
        else
            echo "The directory $AOC_HOME/$2 does not exist. Please create it."
            return 1
        fi
    # We have some other case of arguments
    else
        # We are not in a specific year for AOC
        # so either a random folder or AOC_HOME (root level)
        if [ "$in_year_subdir" = false ]; then
            # We haven't provided a year when we need to
            if [ "$#" -ne 2 ]; then
                echo "You are not in a valid AOC folder."
                echo "Usage: day <day number> <year number>"
                return 1
            fi
        else
            # We have provided some other combination of
            # arguments
            if [ "$#" -ne 1 ]; then
                echo "Usage: day <day number>"
                return 1
            fi
        fi
    fi

    # User input e.g. "1", "2", "12"
    day=$1
    # Pad input e.g. "01", "02", "12"
    day_padded=$(printf "%02d" $1)

    dir_name="day$day_padded"
    file_name="day$day_padded.py"

    # Check if the directory already exists
    if [ -d "$dir_name" ]; then
        cd "$dir_name"
        code . $file_name
        cd ..
        return 0
    fi

    mkdir $dir_name
    cd $dir_name

    year=$(pwd | grep -oE '[0-9]{4}')

    cat <<EOF > $file_name
# https://adventofcode.com/$year/day/$1
from collections import deque, defaultdict
import re

with open("test.txt") as f:
    lines = list(map(str.strip, f.readlines()))


def solve_part_1():
    ans = 0
    for line in lines:
        pass
    return ans


def solve_part_2():
    ans = 0
    for line in lines:
        pass
    return ans


print(f"Part 1 answer: {solve_part_1()}")
print(f"Part 2 answer: {solve_part_2()}")

EOF
    touch "input.txt"
    touch "test.txt"
    code . $file_name
    cd ..
}

