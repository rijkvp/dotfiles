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

update_dotfiles() {
    dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    if [ ! -d $HOME/.dotfiles ]; then
        git clone --bare https://github.com/rijkvp/dotfiles.git $HOME/.dotfiles
    else
        $dotf pull
    fi
    $dotf config status.showUntrackedFiles no
    $dotf checkout
}

install_pacman_packages() {
    sudo pacman -S --needed $1
}

install_mudflow() {
    # make sure directories exist
    bin_dir=$HOME/.local/bin
    mkdir -p $bin_dir

    if [ ! -f "$bin_dir/mudflow" ]; then
      echo "Installing mudflow.."
      wget -q https://github.com/rijkvp/mudflow/releases/download/dev/mudflow -O "$bin_dir/mudflow"
      chmod +x "$bin_dir/mudflow"
    fi
}

# 1: NerdFont name
install_nerdfont() {
    font_dir="$HOME/.local/share/fonts"
    mkdir -p $font_dir
    if [ ! -d $font_dir/$1 ]; then
        echo "Installing Nerd Font '$1'.."
        zip="$font_dir/$1.zip"
        wget -nv -O $zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip
        unzip -d $font_dir/$1 $zip
        rm $zip
    fi
}

setup_zsh() {
    # set zsh as default shell
    if [ "$SHELL" != "/bin/zsh" ]; then
        echo "Set user shell to zsh."
        chsh -s /bin/zsh
    fi
}

install_paru() {
    paru_dir="$HOME/.paru"
    if ! is_installed paru; then
        git clone https://aur.archlinux.org/paru.git $paru_dir
        cd $paru_dir
        makepkg -si
    fi
}

setup_fonts() {
    font_dir=$HOME/.local/share/fonts
    mkdir -p $font_dir

    install_nerdfont Iosevka
    if dialog "Install additional fonts (recommended)?"; then
        install_nerdfont JetBrainsMono
        install_pacman_packages "ttf-dejavu ttf-fira-sans ttf-liberation ttf-opensans ttf-roboto"
    fi
    fc-cache
}

# Scripts starts here
echo "\033[1m >> @rijkp's Arch Linux dotfiles bootstrap script << \033[m"

. /etc/os-release
if [ ! "$ID" = "arch" ] && [ ! "$ID" = "artix" ]; then
  echo "Unsupported distribution '$ID'!"
  exit 0
fi

echo "Updating repositories.."
sudo pacman -Syy

echo "\033[1m [1/5] Essentials. \033[m"
install_pacman_packages "base-devel make git curl wget dash openssh unzip"

if [ ! "$(readlink /usr/bin/sh)" = "dash" ]; then
    sudo ln -sfT dash /usr/bin/sh
    echo "Set dash as default shell."
fi

echo "\033[1m [2/5] Terminal. \033[m"
if dialog "Setup terminal?"; then
    install_pacman_packages "neovim alacritty bat exa skim dust fd ripgrep difftastic starship zsh zsh-syntax-highlighting"
    setup_zsh
    git config --global diff.external difft # difftastic as git diff replacement
fi

echo "\033[1m [3/5] Desktop. \033[m"
if dialog "3. Setup desktop?"; then
    install_paru
    paru -S --needed --noconfirm leftwm-git

    setup_fonts
    install_pacman_packages "polybar rofi dunst picom unclutter sddm slock feh pipewire pipewire-alsa pipewire-jack pipewire-pulse mpd mpc ncmpcpp arc-gtk-theme papirus-icon-theme xcursor-simpleandsoft xdotool xclip scrot"
    install_mudflow
fi

echo "\033[1m [4/5] Applications. \033[m"
if dialog "4. Install default applications?"; then
    install_pacman_packages "thunar firefox zathura zathura-djvu zathura-pdf-mupdf mpv yt-dlp ffmpeg hunspell hunspell-en_us hunspell-nl rsync newsboat"
    install_pacman_packages "gimp"
fi

echo "\033[1m [5/5] Dotfiles. \033[m"
update_dotfiles

if [ ! -f "$HOME/.config/themes/current" ]; then
    echo "Set a theme."
    set-theme
fi
