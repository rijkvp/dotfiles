#!/bin/sh
# @rijkvp's dotfiles bootstrapping script: https://github.com/rijkvp/dotfiles

# 1: command
is_installed() {
    command -v "$1" 1>/dev/null 2>&1
}

# 1: question
dialog() {
    echo "$1 [y/n]"
    read confirm
    if [ "$confirm" = "y" ]; then
        return 0
    else
        return 1
    fi
}

clone_dotfiles() {
    if [ ! -d $HOME/.dotfiles ]; then
        git clone --bare https://github.com/rijkvp/dotfiles.git $HOME/.dotfiles
    fi
    dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    $dotf config status.showUntrackedFiles no
    $dotf checkout
}

install_pacman_packages() {
    sudo pacman -S --needed $1
}

install_mudflow() {
    wget -q https://github.com/rijkvp/mudflow/releases/download/dev/mudflow -O ~/.local/bin/mudflow
    chmod +x ~/.local/bin/mudflow
}

# 1: NerdFont name
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

setup_shell() {
    # make sure directories exist
    bin_dir=$HOME/.local/bin
    mkdir -p $bin_dir

    # set zsh as default shell
    if [ "$SHELL" != "/bin/zsh" ]; then
        echo "Changing default shell to zsh."
        chsh -s /bin/zsh
    else
        echo "zsh is already the default shell"
    fi

    # install zsh syntax highlighting
    if [ ! -d $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting ]; then
        echo "Installing zsh syntax highlighting..."
        mkdir -p $HOME/.local/share/zsh/plugins
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth 1 $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting
    else
        echo "zsh syntax highlighting is already installed."
    fi
}

setup_fonts() {
    font_dir=$HOME/.local/share/fonts
    mkdir -p $font_dir

    # install patched nerd fonts
    install_nerdfont Iosevka
    install_nerdfont FiraCode
    fc-cache
}

# scripts starts here

. /etc/os-release
if [ "$ID" = "arch" ] || [ "$ID" = "artix" ]; then
    echo "Using arch or artix!"
    echo "0. Updating repositories.."
    sudo pacman -Syy
    echo "1. Installing essentials.."
    install_pacman_packages "make git curl wget dash zsh openssh unzip"
    sudo ln -sfT dash /usr/bin/sh

    echo "2. Install terminal stuff.."
    if dialog "Install terminal programs?"; then
        install_pacman_packages "alacritty bat exa skim dust fd ripgrep difftastic"
        git config --global diff.external difft # difftastic as git diff replacement
    fi

    # TODO: Install paru & leftwm
    if dialog "3. Install desktop programs (THIS CAN BREAK YOUR SYSTEM!!)?"; then
        install_pacman_packages "polybar rofi dunst picom unclutter sddm slock feh pipewire pipewire-alsa pipewire-jack pipewire-pulse mpd mpc ncmpcpp arc-gtk-theme"
    fi

    if dialog "4. Install additional applications?"; then
        install_pacman_packages "firefox gimp thunar code libreoffice-fresh hunspell hunspell-en_us hunspell-nl zathura zathura-djvu zathura-pdf-mupdf ttf-dejavu ttf-fira-sans ttf-liberation ttf-opensans ttf-roboto yt-dlp ffmpeg mpv newsboat rsync"
    fi
else
    echo "Unsupported distro '$ID'! Things might break!"
fi

clone_dotfiles
install_mudflow

if dialog "Setup shell?"; then
    setup_shell
fi

if dialog "Download nerd fonts?"; then
    setup_fonts
fi

echo "Done!"
echo "You might want to restart the shell and set a theme."
