#!/bin/bash
set -e

NVIM_CONFIG_DIR="$HOME/.config/nvim"
SRC_DIR="$(dirname "$0")/settings/nvim"

echo "Installing Neovim config to $NVIM_CONFIG_DIR..."
mkdir -p "$NVIM_CONFIG_DIR/lua"

cp "$SRC_DIR/init.lua" "$NVIM_CONFIG_DIR/init.lua"
cp "$SRC_DIR/lua/plugins.lua" "$NVIM_CONFIG_DIR/lua/plugins.lua"

echo "Neovim config copied. Installing plugins with lazy.nvim..."
nvim --headless "+Lazy! sync" +qa

echo "Neovim configuration complete with lazy.nvim and Nord theme!"
