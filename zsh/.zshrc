
# Load and initialise completion system
autoload -Uz compinit
compinit

# Initialise Zap plugin manager
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Load plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Fuzzy finder
source <(fzf --zsh)

# Aliases
alias ls="ls -G"
alias ll="ls -AlG"
alias editrc="nvim $ZDOTDIR/.zshrc"
alias sourcerc="source $ZDOTDIR/.zshrc"
alias editprofile="nvim $ZDOTDIR/.zprofile"
alias python="python3"
alias vimc="/usr/bin/vim"
alias vim="nvim"
# alias vimc="VIMINIT=\"source $XDG_CONFIG_HOME/vim/.vimrc\" /usr/bin/vim"
# alias vim="nvim"

# Terminal prompt
source "$ZDOTDIR/prompt.zsh"

# Fast node manager (fnm)
eval "$(fnm env --use-on-cd --shell zsh)"

# AOC Utils
source "$ZDOTDIR/aoc-utils.zsh"

