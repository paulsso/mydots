#!/bin/bash

set -e

SOURCE_DIR="$(dirname "$0")/settings/vscode"
TARGET_DIR="$HOME/.config/Code/User"

echo "Creating VSCode user settings directory at $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

echo "Copying VSCode configuration files..."
cp "$SOURCE_DIR/settings.json" "$TARGET_DIR/settings.json"
cp "$SOURCE_DIR/extensions.json" "$TARGET_DIR/extensions.json"

# Optional: include launch and tasks at workspace level if needed
WORKSPACE_VSCODE_DIR="$PWD/.vscode"
mkdir -p "$WORKSPACE_VSCODE_DIR"
cp "$SOURCE_DIR/launch.json" "$WORKSPACE_VSCODE_DIR/launch.json"
cp "$SOURCE_DIR/tasks.json" "$WORKSPACE_VSCODE_DIR/tasks.json"

echo "VSCode configuration applied."

