#!/bin/bash

set -e

echo "Installing Terminator terminal emulator..."
sudo apt update
sudo apt install -y terminator

echo "Creating default configuration..."
mkdir -p "$HOME/.config/terminator"

cat > "$HOME/.config/terminator/config" <<EOF
[global_config]
  focus = system
[keybindings]
[profiles]
  [[default]]
    use_system_font = false
    font = Fira Code Nerd Font Mono 10
    scrollback_lines = 10000
    show_titlebar = false
    cursor_shape = underline
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
EOF

echo "Terminator installed and configured with Nerd Font."
