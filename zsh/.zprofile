
# XDG Paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA="$HOME/.local/share"

# Tell login shell where to find config files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
pyenv rehash

export SKHD_CONFIG="$HOME/.config/skhd/skhdrc"
export PATH="$HOME/Library/pnpm:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
