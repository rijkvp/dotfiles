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
        alias dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
        dotf config status.showUntrackedFiles no
        dotf checkout
    else
        echo "Dotfiles already cloned"
    fi
}

install_pacman_packages() {
    sudo pacman -S --needed $1
}

# 1: name
# 2: repo path
# 3: file
install_github_bin() {
    if is_installed $1; then
        echo "$1 already installed"
    else
        echo "Installing $1.."
        wget -q https://github.com/$2/releases/latest/download/$3 -O $3
        tar -xf $3 -C $bin_dir
        rm $3
    fi
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

    # Install stuff from GitHub on other distros
    # starship: shell prompt
    install_github_bin starship starship/starship starship-x86_64-unknown-linux-gnu.tar.gz
    # zellij: terminal multiplexer
    install_github_bin zellij zellij-org/zellij zellij-x86_64-unknown-linux-musl.tar.gz
}

setup_fonts() {
    font_dir=$HOME/.local/share/fonts
    mkdir -p $font_dir

    # install patched nerd fonts
    install_nerdfont FiraCode
    install_nerdfont Iosevka
    install_nerdfont JetBrainsMono
    fc-cache
}

# scripts starts here

. /etc/os-release
if [ "$ID" = "arch" ] || [ "$ID" = "artix" ]; then
    echo "Using arch or artix!"
    echo "1. Installing essentials.."
    install_pacman_packages "make git curl wget dash zsh openssh"
    echo "Set dash to replace sh"
    sudo ln -sfT dash /usr/bin/sh

    echo "2. Install terminal stuff.."
    if dialog "Install terminal stuff?"; then
        install_pacman_packages "alacritty zellij starship bat exa skim dust fd ripgrep ranger"
    fi

    if dialog "3. Install desktop programs (THIS CAN BREAK YOUR SYSTEM!!)?"; then
        install_pacman_packages "dunst picom unclutter sddm slock feh pipewire pipewire-alsa pipewire-jack pipewire-pulse mpd mpc mpd ncmpcpp"
        # TODO: Install/enable services for sddm openssh mpd (on Artix)
    fi

    if dialog "4. Install applications?"; then
        install_pacman_packages "firefox gimp code libreoffice-fresh hunspell hunspell-en_us hunspell-nl zathura zathura-djvu zathura-pdf-mupdf ttf-dejavu ttf-fira-sans ttf-liberation ttf-opensans ttf-roboto yt-dlp ffmpeg mpv newsboat rsync"
    fi
else
    echo "Unsupported distro '$ID'! Things might break!"
fi

clone_dotfiles

if dialog "Setup shell?"; then
    setup_shell
fi

if dialog "Setup fonts?"; then
    setup_fonts
fi

echo "Done!"
echo "You might want to restart the shell and set a theme."
