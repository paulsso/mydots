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

# Alacritty Installation
install_alacritty() {
    apt_install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env # Ensure Rust environment is active
    rustup override set stable
    rustup update stable
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty || return
    cargo build --release
    sudo cp target/release/alacritty /usr/local/bin/alacritty # Use /usr/local/bin
    cd ..
    rm -rf alacritty
}

# i3 Installation
install_i3() {
    if ! apt_install wget libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
                     libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
                     libstartup-notification0-dev libxcb-randr0-dev \
                     libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
                     libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
                     autoconf libxcb-xrm0 libxcb-xrm-dev automake \
                     libxcb-shape0-dev pkg-config meson; then
        handle_error
    fi

    wget -c https://i3wm.org/downloads/i3-4.23.tar.xz -O i3-4.23.tar.xz || handle_error
    tar xfv i3-4.23.tar.xz || handle_error
    cd i3-4.23 || return
    mkdir -p build && cd build || return
    meson ..
    ninja
    sudo ninja install
    
    sudo echo "[Desktop Entry]
    Name=i3 
    Comment=improved dynamic tiling window manager  
    Exec=i3 
    TryExec=i3 
    Type=Application 
    X-LightDM-DesktopName=i3 
    DesktopNames=i3  
    Keywords=tiling;wm;windowmanager;window;manager;" > /usr/share/xsessions/i3.desktop

    cd ../..
    rm -rf i3-4.23
}

# Install i3 blovks
install_i3blocks() {
    cd /tmp
    git clone https://github.com/vivien/i3blocks
    cd i3blocks
    ./autogen.sh
    ./configure
    make
    make install
    cd /tmp
    rm -rf i3blocks
}

# Go installation
install_go() {
    cd /tmp
    wget -c https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O go1.22.0.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
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

# Apply configuration files
apply_config_files() {
    ln -s $HOME/mydots/config/i3 $HOME/.config/i3
    ln -s $HOME/mydots/config/alacritty $HOME/.config/alacritty
    ln -s $HOME/mydots/config/nvim $HOME/.config/nvim
    ln -s $HOME/mydots/config/i3blocks $HOME/.config/i3blocks
    ln -s $HOME/mydots/config/i3/i3exit /usr/bin/i3exit
    ln -s $HOME/mydots/config/zshrc $HOME/.config/zshrc
    ln -s $HOME/.config/zshrc/config $HOME/.zshrc
    cp -r $HOME/mydots/fonts $HOME/.fonts
}

# Main development tools
install_python_pip || handle_errors
install_go || handle_errors
install_docker || handle_errors
install_gcc || handle_errors

# Main installation prompts
prompt_install "Install zsh and ohmyzsh?" install_zsh
prompt_install "Install neovim?" install_neovim
prompt_install "Install Alacritty?" install_alacritty
prompt_install "Install i3?" install_i3 install_i3blocks
prompt_install "Apply configuration files?" apply_config_files

echo "Setup complete."
exit 0
