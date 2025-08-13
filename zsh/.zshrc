
# Load and initialise completion system
autoload -Uz compinit
compinit -C -d "$ZDOTDIR/.zcompdump"

# Initialise Zap plugin manager
[ -f "$XDG_DATA_HOME/zap/zap.zsh" ] || zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
source "$XDG_DATA_HOME/zap/zap.zsh"

# Load plugins
plug "Aloxaf/fzf-tab" # Must be loaded before plugins that wrap widgets (e.g. autosuggestions)
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Shell integrations
eval "$(zoxide init --cmd cd zsh)" # Zoxide
source <(fzf --zsh) # Fuzzy finder (fzf)

# Keybindings
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-za-z}" # Case insensitive completion
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}" # Coloured directories
zstyle ":completion:*" menu no # Don't use default completion menu
zstyle ':completion:*:git-checkout:*' sort false # Disable sort when completing `git checkout`
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath' # Preview directory content with cd
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always $realpath' # Preview directory content with ls

# History
HISTSIZE=5000
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls="eza $eza_params"
alias ll="eza --all --long --header $eza_params"
alias lt="eza --tree $eza_params"
alias tree="eza --tree $eza_params"

alias editrc="nvim $ZDOTDIR/.zshrc"
alias sourcerc="source $ZDOTDIR/.zshrc"
alias df="nvim $DOTFILES" # Edit dotfiles
alias cddf="cd $DOTFILES" # Change dir to dotfiles

alias python="python3"
alias vimc="/usr/bin/vim"
alias vim="nvim"

# Terminal prompt
source "$ZDOTDIR/prompt.zsh"

# AOC Utils
source "$ZDOTDIR/aoc-utils.zsh"

