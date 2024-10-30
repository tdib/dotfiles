
# XDG Paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Tell login shell where to find config files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# Set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Android
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH" # Provide access to `adb` and other terminal commands
export PATH="/Applications/Android Studio.app/Contents/MacOS:$PATH" # Allow access to `studio` terminal command

export SKHD_CONFIG="$HOME/.config/skhd/skhdrc"
export PATH="$HOME/Library/pnpm:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

