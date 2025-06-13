# Makefile for setting up development environment

SHELL := /bin/bash

.PHONY: help all install_i3 install_zsh configure_i3 configure_ohmyzsh install_cpp install_python install_docker install_tools configure_vscode_user configure_nvim 

# Default command
help:
	@echo "Usage: make [target]"
	@echo "Available targets:"
	@echo "  all                   - Run full environment setup"
	@echo "  install_i3           - Install i3 window manager"
	@echo "  install_zsh          - Install zsh and Oh My Zsh"
	@echo "  configure_i3         - Configure i3 (noop)"
	@echo "  configure_ohmyzsh    - Configure zsh theme and plugins"
	@echo "  install_cpp          - Install C/C++ compilers and tools"
	@echo "  install_python       - Install Python and setup default venv"
	@echo "  install_docker       - Install Docker and CLI tools"
	@echo "  install_tools        - Install misc tools like VSCode, fzf, etc."
	@echo "  configure_vscode_user - Copy VSCode user config files"
	@echo "  configure_nvim       - Setup Neovim with sane defaults"

all: install_python install_cpp install_i3 install_zsh install_docker install_tools configure_ohmyzsh configure_vscode_user configure_nvim

install_i3:
	@./scripts/install_i3.sh

install_zsh:
	@./scripts/install_zsh.sh

configure_i3:
	@./scripts/configure_i3.sh

configure_ohmyzsh:
	@./scripts/configure_ohmyzsh.sh

install_cpp:
	@./scripts/install_cpp.sh

install_python:
	@./scripts/install_python.sh

install_docker:
	@./scripts/install_docker.sh

install_tools:
	@./scripts/install_tools.sh

configure_vscode_user:
	@./scripts/configure_vscode_user.sh

configure_nvim:
	@./scripts/configure_nvim.sh
