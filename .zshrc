zstyle :compinstall filename '/home/rijkvp/.zshrc'

autoload -Uz compinit
compinit

# Add to path
source ~/scripts/goto.sh
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts:$PATH
export PATH=$HOME/repos/flutter/bin:$PATH

########## 
# COLORS #
##########


###########
# Aliases #
###########
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# Exa (better ls)
alias ls='exa --icons --group-directories-first'
alias lsa='exa --icons -1 -la --group-directories-first'
# Neovim
alias v='nvim'
alias sv='sudo nvim'
alias s='systemctl'
# File managers
alias fm='ranger'
alias gfm='pcmanfm'
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

alias todo='v ~/docs/notes/todo.md'

alias code='vscodium'
# Git
alias clone='git clone'
alias qcom='git add -A && git commit -a -m' # Quick Commit
alias push='git push'
# Bare dotfiles git repo
alias cfg='/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'

# Start Starship
eval "$(starship init zsh)"

# VI Mode
set -o vi

# zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
