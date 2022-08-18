#!/bin/zsh
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit # Add to path
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/scripts:$PATH

###########
# Aliases #
###########

# Bare dotfiles git repo
alias dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
# Fuzzy find
alias skc='cd $(sk)'
alias skv='cd $(sk) && nvim .'
# cd back
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# Exa (better ls)
alias ls='exa --icons -1 -s extension --group-directories-first'
alias lsa='exa --icons -1 -la -s extension --group-directories-first'
# Git
alias clone='git clone'
alias gitq='git add -A && git commit -a -m' # Quick Commit
alias push='git push'
# Neovim
alias nv='nvim'
# File managers
alias fm='ranger'
alias gfm='pcmanfm'
# Notes folder
alias kb='cd $HOME/docs/notes && nv .'
# Newsboat
alias nb='newsboat'
# Package mangement
alias pacup="sudo pacman -Syu"
alias pacs="pacman -Ss"
alias paci="sudo pacman -S"
alias pacr="sudo pacman -Rsnu"
alias pacclean="sudo pacman -Rs $(pacman -Qtdq)"
alias auru="paru -Syu"
alias auri="paru -S"
alias aurs="paru -Ss"
alias mirrorup="sudo reflector -f 30 -l 30 -n 20 -c 'Netherlands,Germany,Belgium' --verbose --save /etc/pacman.d/mirrorlist"

alias todo='nvim ~/docs/notes/todo.md'
# Downloads best audio, converts to opus, embeds metadata
alias ytdl-audio='yt-dlp -f "ba[ext=m4a]" -x --audio-format opus --embed-metadata --xattrs -o "%(title)s.%(ext)s"'
alias ytdl-album='yt-dlp -f "ba[ext=m4a]" -x --audio-format opus --embed-metadata --xattrs -o "%(album)s/%(title)s.%(ext)s"'
# Additionally parses metadata from 'Arist - Title' format
alias ytdl-audio-title='yt-dlp -f "ba[ext=m4a]" -x --audio-format opus --embed-metadata --xattrs -o "%(title)s.%(ext)s" --parse-metadata "title:%(artist)s - %(title)s"'
alias mp='ncmpcpp'



# Start Starship
eval "$(starship init zsh)"

# VI Mode
set -o vi

# zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
