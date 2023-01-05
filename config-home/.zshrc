#!/bin/zsh
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

export EDITOR="nvim"
# Additional paths
export PATH=$HOME/dotfiles/scripts:$HOME/.local/bin:$HOME/.cargo/bin:$PATH
# Fix Nix
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# Check if command is available
is_installed() {
    command -v "$1" 1>/dev/null 2>&1
}

# Git
alias gitq='git add . && git commit' # quick add & commit

# File Magement
# Confirmations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
# Directory upwards
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# Better ls
alias ls='exa --icons -s extension --group-directories-first'
alias lsa='exa --icons -1 -la -s extension --group-directories-first'

# Program
spawn() {
    nohup xdg-open $1 > /dev/null 2>&1 &
}

# Fuzzy find
if is_installed sk; then
    export SKIM_DEFAULT_COMMAND="fd"
    alias sf='spawn $(sk -c "fd --type f --strip-cwd-prefix")'
    # Skim directory in home
    alias sd='cd $HOME/$(sk -c "fd --type d --base-directory $HOME")'
    alias sv='cd $HOME/$(sk -c "fd --type d --base-directory $HOME") && nvim .'
    # Subdirectory
    alias ssd='cd $(sk -c "fd --type d --strip-cwd-prefix")'
fi


alias open='xdg-open'
alias vim='nvim'
alias nb='newsboat'
alias mp='ncmpcpp'
alias fm='ranger'

# Package mangement
alias pacup="sudo pacman -Syu"
alias pacs="pacman -Ss"
alias paci="sudo pacman -S"
alias pacr="sudo pacman -Rsnu"
alias pacclean="sudo pacman -Rs $(pacman -Qtdq)"

# YT-DLP
if is_installed yt-dlp; then
    # Downloads best audio, converts to opus, embeds metadata
    alias ytdl-audio='yt-dlp -f "ba[ext=m4a]" -x --audio-format opus --embed-metadata --xattrs -o "%(title)s.%(ext)s"'
    alias ytdl-album='yt-dlp -f "ba[ext=m4a]" -x --audio-format opus --embed-metadata --xattrs -o "%(album)s/%(title)s.%(ext)s"'
fi

if is_installed zoxide; then
    eval "$(zoxide init zsh)" # Zoxide
fi

# Latex
#
if is_installed watchexec; then
    latexw() {
        watchexec -f $1 "pdflatex -halt-on-error -interaction=nonstopmode $1"
    }
    pdw() {
        watchexec -f $1 "pandoc $1 -o $2"
    }
fi


eval "$(starship init zsh)" # Starship

set -o vi # VI Mode

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
