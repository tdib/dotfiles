#!/bin/zsh

set -e  # Exit immediately if a command fails

# Aliases
git config --global alias.s "status"
git config --global alias.su "status -u"
git config --global alias.b "branch"
git config --global alias.ck "checkout"
git config --global alias.d "diff"
git config --global alias.ds "diff --staged"
git config --global alias.l "log"
git config --global alias.cm "commit -m"
git config --global alias.cma "commit --amend"
git config --global alias.cman "commit --amend --no-edit"
git config --global alias.rb "rebase"
git config --global alias.rbi "rebase -i"
git config --global alias.rba "rebase --abort"
git config --global alias.rbc "rebase --continue"
git config --global alias.bd "branch -D"
git config --global alias.p "push"
git config --global alias.pf "push -f"
git config --global alias.sp "stash pop"
git config --global alias.sl "stash list"
git config --global alias.ss "stash save -u"
git config --global alias.sd "stash drop"
git config --global alias.sa "stash apply"
git config --global alias.r "restore"
git config --global alias.rs "restore --staged"

# User Information
git config --global user.name "Dib"

# Core Settings
git config --global core.editor "nvim"
git config --global core.pager "delta"

# Delta Settings
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.side-by-side true

# Merge Conflict Style
git config --global merge.conflictstyle "zdiff3"

# Performance Optimizations
git config --global core.preloadindex true
git config --global core.fscache true
git config --global core.fsmonitor true

