#!/bin/bash

set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install common CLI tools
echo "Installing fzf (fuzzy finder)..."
sudo apt install -y fzf

# Enable fzf keybindings and completion
if [[ $SHELL == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ $SHELL == */bash ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

if ! grep -q "fzf key-bindings" "$SHELL_RC"; then
  echo "Configuring fzf keybindings and completion in $SHELL_RC..."
  echo "# fzf configuration" >> "$SHELL_RC"
  echo "[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash" >> "$SHELL_RC"
  echo "[ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash" >> "$SHELL_RC"
fi

echo "Installing neovim (modern vim)..."
sudo apt install -y neovim

echo "Installing GitHub CLI (gh)..."
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y

echo "Installing net-tools (for networking utilities like ifconfig)..."
sudo apt install -y net-tools

# File tree viewer
if ! command -v tree &> /dev/null; then
  echo "Installing tree (directory viewer)..."
  sudo apt install -y tree
fi

# Install VS Code
if ! command -v code &> /dev/null; then
  echo "Installing Visual Studio Code..."
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code
  rm microsoft.gpg
else
  echo "VS Code is already installed."
fi

# Additional useful tools
echo "Installing additional useful CLI tools..."
sudo apt install -y htop bat ripgrep jq

echo "All tools installed successfully."
