#!/bin/zsh
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

export EDITOR="nvim"
# Additional paths
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH

# Check if command is available
is_installed() {
    command -v "$1" 1>/dev/null 2>&1
}

# Git
alias gitq='git add . && git commit' # quick add & commit
alias dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

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

# Fuzzy find
if is_installed sk; then
    alias s='cd $(sk)'
    alias v='nvim $(sk)'
fi

# Programs
spawn() {
    nohup xdg-open $1 > /dev/null 2>&1 &
}

alias open='xdg-open'
alias vim='nvim'
alias gvim='neovide'
alias glvim='neovide --neovim-bin $HOME/.local/bin/lvim'
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

eval "$(starship init zsh)" # Starship

set -o vi # VI Mode

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
