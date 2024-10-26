# Dotfiles

Config files for zsh and terminal stuff live here :)

## Installation on a new machine

Simply run `./setup-dotfiles.sh`, and the rest will be handled for you. This script will:

1. Symlink the `.zprofile` from [zsh/.zprofile] to `$HOME/.zprofile` so it is visible to the terminal
2. Install some packages from the [Brewfile](setup/Brewfile)
3. Run `brew doctor` to ensure there are no issues with Homebrew
4. Update, upgrade, and cleanup Homebrew

