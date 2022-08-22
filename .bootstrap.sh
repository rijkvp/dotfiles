#!/bin/sh

git clone --bare https://github.com/rijkvp/dotfiles.git $HOME/.dotfiles
alias dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
dotf config status.showUntrackedFiles no
dotf checkout

bin_dir=$HOME/.local/bin
font_dir=$HOME/.local/share/fonts
mkdir -p $bin_dir
mkdir -p $font_dir

has() {
    command -v "$1" 1>/dev/null 2>&1
}

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

# 1: name
# 2: repo path
# 3: file
install_github_bin() {
    if has $1; then
        echo "$1 already installed"
    else
        echo "Installing $1.."
        wget -q https://github.com/$2/releases/latest/download/$3 -O $3
        tar -xf $3 -C $bin_dir
        rm $3
    fi
}

# scripts starts here

# set zsh as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Changing default shell to zsh."
    chsh -s /bin/zsh
fi

# install zsh syntax highlighting
if [ ! -d $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting ]; then
    echo "Installing zsh syntax highlighting..."
    mkdir -p $HOME/.local/share/zsh/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth 1 $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting
else
    echo "zsh syntax highlighting is already installed."
fi

# starship: shell prompt
install_github_bin starship starship/starship starship-x86_64-unknown-linux-gnu.tar.gz
# zellij: terminal multiplexer
install_github_bin zellij zellij-org/zellij zellij-x86_64-unknown-linux-musl.tar.gz

# install patched nerd fonts
install_nerdfont FiraCode
install_nerdfont Iosevka
install_nerdfont JetBrainsMono
fc-cache
