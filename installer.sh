#!/bin/bash
cd /tmp

# Function to handle errors
handle_error() {
    echo "An error occurred."
    while true; do
        read -p "Do you want to try again? (y/n): " yn
        case $yn in
            [Yy]* | "" ) return 0;; # Return 0 to indicate a retry
            [Nn]* ) echo "Exiting script."; exit 1;; # Exit the script with an error
        esac
    done
}

read -p "Install zsh and ohmyzsh? (Y/n): " zsyn

case $zsyn in
    [Yy]* | "" )
        sudo apt update
        sudo apt install zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
        cd /tmp
        ;;
    [Nn]* ) echo "Skipping zsh." ;; # Continue running script
esac

read -p "Install neovim? (Y/n): " nvyn

case $nvyn in
    [Yy]* | "" )
        wget -c https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O nvim.appimage
        chmod u+x nvim.appimage
        sudo cp nvim.appimage /usr/bin/nvim
        rm nvim.appimage
        cd /tmp
        ;;
    [Nn]* ) echo "Skipping neovim." ;; # Exit the script with an error
esac

read -p "Install Alacritty? (Y/n): " alyn

case $alyn in
    [Yy]* | "" )
        sudo apt update
        sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
        
        if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; then
            handle_error || continue
        fi
        
        if ! rustup override set stable; then
            handle_error || continue
        fi

        if ! rustup update stable; then
            handle_error || continue
        fi

        git clone https://github.com/alacritty/alacritty.git
        cd alacritty
        cargo build --release
        sudo cp target/release/alacritty /usr/bin/alacritty
        cd /tmp
        rm -rf alacritty
        ;;
    [Nn]* ) echo "Skipping Alacritty." ;; # Exit the script with an error
esac

read -p "Install i3? (Y/n): " i3yn

case $i3yn in
    [Yy]* | "" )
        sudo apt update
        if ! sudo apt install wget libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
                         libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
                         libstartup-notification0-dev libxcb-randr0-dev \
                         libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
                         libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
                         autoconf libxcb-xrm0 libxcb-xrm-dev automake \
                         libxcb-shape0-dev pkg-config meson; then
            handle_error || continue
        fi

        if ! wget -c https://i3wm.org/downloads/i3-4.23.tar.xz -O i3-4.23.tar.xz; then
            handle_error || continue
        fi
        
        if ! tar xfv i3-4.23.tar.xz; then
            handle_error || continue
        fi
        
        if ! sudo apt install suckless-tools lxappearance; then
            handle_error || continue
        fi

        cd i3-4.23
        mkdir build
        cd build
        meson ..
        ninja
        sudo ninja install
        sudo cp $HOME/mydots/xsessions/i3.desktop /usr/share/xsessions/i3.desktop
        cd /tmp
        rm -rf i3-4.23 
        exec i3
        ;;
    [Nn]* ) echo "Skipping i3." ;; # Exit the script with an error
esac

read -p "Apply configuration files? (Y/n): " yn

case $yn in
    [Yy]* | "")
        cp $HOME/mydots/.config $HOME;;
    [Nn]* ) echo "Skipping configuration files" ;;
esac

exit 0
