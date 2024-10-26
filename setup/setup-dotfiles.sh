#!/bin/zsh

set -e  # Exit immediately if a command fails

# Symlink .zprofile to home directory
echo "Creating symlink for .zprofile..."
ln -sf $HOME/.config/zsh/.zprofile $HOME/.zprofile
ln -sf $HOME/.config/vim/.vimrc $HOME/.vimrc

# Install Homebrew if it's not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed. Skipping installation..."
fi

# Run Brewfile only if it needs to install anything
if brew bundle check --file=$HOME/.config/setup/Brewfile &>/dev/null; then
  echo "All Brewfile packages are already installed."
else
  echo "Installing missing packages from Brewfile..."
  brew bundle --file=$HOME/.config/setup/Brewfile
fi

# Verify Homebrew installation health
echo "Verifying Homebrew setup..."
brew doctor || echo "Some issues detected. Check brew doctor output."

# Update and clean up Homebrew
echo "Updating and cleaning up Homebrew..."
brew update && brew upgrade && brew cleanup

echo "Setup complete!"

