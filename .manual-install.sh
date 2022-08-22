#!/bin/sh 
bin_dir=$HOME/.local/bin
font_dir=$HOME/.local/share/fonts
# Install stuff mannualy
mkdir -p $bin_dir
mkdir -p $font_dir

# Install some patched nerd fonts
install_nerdfont() {
    if [ ! -d $font_dir/$1 ]; then 
        echo "Installing Nerd Font '$1'.."
        wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip
        unzip -q -d $font_dir/$1 $1.zip
        rm $1.zip
    else
        echo "Nerd Font '$1' already installed"
    fi
}

install_nerdfont FiraCode
install_nerdfont Iosevka
install_nerdfont JetBrainsMono
fc-cache

# 1: name
# 2: repo path
# 3: file
install_github_bin() {
    if [ ! -f $bin_dir/$1 ]; then 
        echo "Installing $1.."
        wget -q https://github.com/$2/releases/latest/download/$3 -O $3
        tar -xf $3 -C $bin_dir
        rm $3
    else
        echo "$1 already installed"
    fi
}

# Shell stuff

echo "Enter your password. Changing default shell to zsh."
chsh -s /bin/zsh

if [ ! -f $HOME/.local/share/zsh/plugins ]; then 
    echo "Installing zsh syntax highlighting..."
    mkdir -p $HOME/.local/share/zsh/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth 1 $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting
else
    echo "zsh syntax highlighting is already installed."
fi
# starship
install_github_bin starship starship/starship starship-x86_64-unknown-linux-gnu.tar.gz
# zellij
install_github_bin zellij zellij-org/zellij zellij-x86_64-unknown-linux-musl.tar.gz

