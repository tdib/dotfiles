# DEFAULT DIR
cd ~/Code



# ALIASES
alias ls="ls -G"
alias ll="ls -AlG"



# PROMPT
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%F{magenta} %b%f'
zstyle ':vcs_info:git:*' actionformats '%F{magenta} %b %F{red}[!]%f'
zstyle ':vcs_info:git:*' check-for-changes true

setopt PROMPT_SUBST # Allow var substitutions in the prompt

precmd() { 
    vcs_info 
    git_changes=""
    if [[ -n $vcs_info_msg_0_ ]]; then
        if [[ -n $(git status --short 2> /dev/null) ]]; then
            git_changes="%F{red}[!]%f "
        fi
        PROMPT='
%F{cyan}%~%f on ${vcs_info_msg_0_} ${git_changes}
%F{yellow}%f  '
    else
        PROMPT='
%F{cyan}%~%f
%F{yellow}%f  '
    fi
}



# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh



# PNPM
export PNPM_HOME="/Users/dib/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac



# TAB TITLE
precmd() {
  dir_name=$(basename $(dirname $PWD))/$(basename $PWD)
  echo -ne "\e]1;${dir_name}\a"
}

