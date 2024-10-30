
# Load vcs_info for version control awareness
autoload -Uz vcs_info

# Configure vcs_info styles for git
zstyle ':vcs_info:git:*' formats '%F{magenta} %b%f'
zstyle ':vcs_info:git:*' actionformats '%F{magenta} %b %F{red}[!]%f'
zstyle ':vcs_info:git:*' check-for-changes true

# Allow variable substitutions in the prompt
setopt PROMPT_SUBST

# Define precmd to set the tab title and prompt dynamically
precmd() {
    # Set tab title to the current directory name
    dir_name=${PWD##*/}
    echo -ne "\e]1;${dir_name}\a"

    # Update vcs_info to reflect the latest git status
    vcs_info 

    git_changes=""
    # Check if currently in git repo
    if [[ -n $vcs_info_msg_0_ ]]; then
        # Check for changes (git plumbing for git status)
        if ! git diff --quiet --ignore-submodules --cached || ! git diff-files --quiet --ignore-submodules; then
            git_changes="%F{red}[!]%f "
        fi
        # Prompt when in a git repo, with symbol indicating any changes
        PROMPT='
%F{cyan}%~%f on ${vcs_info_msg_0_} ${git_changes}
%F{yellow}%f  '
    else
        # Prompt when not in a git repo
        PROMPT='
%F{cyan}%~%f
%F{yellow}%f  '
    fi
}

