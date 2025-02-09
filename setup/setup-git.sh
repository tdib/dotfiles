#!/bin/zsh

set -e  # Exit immediately if a command fails

# Aliases
git config --global alias.s "status"
git config --global alias.b "branch"
git config --global alias.ck "checkout"
git config --global alias.d "diff"
git config --global alias.ds "diff --staged"
git config --global alias.l "log"
git config --global alias.cm "commit"
git config --global alias.cma "commit --amend"
git config --global alias.cman "commit --amend --no-edit"

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

