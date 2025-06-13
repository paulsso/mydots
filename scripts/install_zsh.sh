#!/bin/bash

set -e

# Install zsh
if ! command -v zsh &> /dev/null; then
  echo "Installing zsh..."
  sudo apt update
  sudo apt install -y zsh
else
  echo "zsh is already installed."
fi

# Set zsh as the default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting zsh as the default shell..."
  chsh -s $(which zsh)
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

echo "zsh and Oh My Zsh installation complete. Restart your terminal or log out and back in for changes to take effect."
#!/bin/bash

set -e

# Install zsh
if ! command -v zsh &> /dev/null; then
	  echo "Installing zsh..."
	    sudo apt update
	      sudo apt install -y zsh
      else
	        echo "zsh is already installed."
fi

# Set zsh as the default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
	  echo "Setting zsh as the default shell..."
	    chsh -s $(which zsh)
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	  echo "Installing Oh My Zsh..."
	    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
	      echo "Oh My Zsh is already installed."
fi

echo "zsh and Oh My Zsh installation complete. Restart your terminal or log out and back in for changes to take effect."

