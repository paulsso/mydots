#!/bin/bash

set -e

ZSHRC="$HOME/.zshrc"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -f "$ZSHRC" ]; then
  echo "$ZSHRC not found. Ensure Oh My Zsh is installed first."
  exit 1
fi

# Set theme to "half-life"
echo "Setting Oh My Zsh theme to 'half-life'..."
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="half-life"/' "$ZSHRC"

# Enable plugins: git, zsh-syntax-highlighting, zsh-autosuggestions
echo "Enabling 'git', 'zsh-syntax-highlighting', and 'zsh-autosuggestions' plugins..."
sed -i 's/^plugins=(.*/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' "$ZSHRC"

# Source plugins at the end of .zshrc if not already there
if ! grep -q "zsh-syntax-highlighting" "$ZSHRC"; then
  echo "Adding plugin sourcing to $ZSHRC..."
  echo "source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"
fi

if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
  echo "source \$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$ZSHRC"
fi

echo "Oh My Zsh theme set to 'half-life' and plugins enabled. Restart your shell to see the changes."

