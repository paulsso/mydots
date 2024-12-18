#!/bin/bash

# Navigate to the /tmp directory at the start of the script
cd /tmp || { echo "Failed to change directory to /tmp"; exit 1; }

# Function to update and install packages
apt_install() {
    sudo apt update && sudo apt install -y "$@"
}

# Improved error handling function
handle_error() {
    echo "An error occurred."
    while true; do
        read -rp "Do you want to try again? (y/n): " yn
        case $yn in
            [Yy]* | "" ) return 0;; # Allow retry
            [Nn]* ) echo "Exiting script."; exit 1;; # Exit script with error
        esac
    done
}

# Function to prompt for installation
prompt_install() {
    local prompt_message="$1"
    local install_command="$2"
    
    read -rp "$prompt_message (Y/n): " response
    if [[ $response =~ ^[Yy]*$ ]] || [[ -z $response ]]; then
        eval "$install_command" || handle_error
    else
        echo "Skipping $prompt_message."
    fi
}

# Zsh and Oh-My-Zsh Installation
install_zsh() {
    apt_install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

# Neovim Installation
install_neovim() {
    apt_install vifm
    wget -c https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -O nvim-linux64.tar.gz
    tar xzvf nvim-linux64.tar.gz
    sudo cp -r nvim-linux64 /usr/local/ # Use /usr/local for software not managed by apt
    sudo ln -sf /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim
    sudo ln -sf /usr/local/bin/nvim /usr/local/bin/vim
}

# install pyton-pip
install_python_pip() {
    sudo apt update
    sudo apt install python3.10 python3-pip python3.10-venv
}

# Install gcc
install_gcc() {
    sudo apt update
    sudo apt install build-essential manpages-dev
}

# install docker
install_docker() {
    # Remove old/unofficial
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

    # Add Docker's oficial GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install docker v 24
    export VERSION_STRING=5:24.0.0-1~ubuntu.22.04~jammy
    sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin
}

# Main development tools
install_python_pip || handle_errors
install_docker || handle_errors
install_gcc || handle_errors

echo "Setup complete."
exit 0
