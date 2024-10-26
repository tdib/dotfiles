
# Set up git stuff
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%F{magenta} %b%f'
zstyle ':vcs_info:git:*' actionformats '%F{magenta} %b %F{red}[!]%f'
zstyle ':vcs_info:git:*' check-for-changes true

# Allow var substitutions in the prompt
setopt PROMPT_SUBST

precmd() { 
    # Tab title
    dir_name=$(basename $(dirname $PWD))/$(basename $PWD)
    echo -ne "\e]1;${dir_name}\a"

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

