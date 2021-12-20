zstyle :compinstall filename '/home/rijkvp/.zshrc'

autoload -Uz compinit
compinit

# Add to path
source ~/dev/scripts/goto.sh
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/dev/scripts:$PATH

########## 
# COLORS #
##########


###########
# Aliases #
###########
alias ls='exa --icons -1'
alias lsa='exa --icons -1 -la'

# Use Neovim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias sv='sudo nvim'

alias s='systemctl'
alias todo='v ~/docs/notes/todo.md'

# Git
alias gitcom='git add -A && git commit -a -m'

# Bare dotfiles git repo
alias cfg='/usr/bin/git --git-dir=$HOME/dev/projects/dotfiles --work-tree=$HOME'

alias g='goto'

# Start Starship
eval "$(starship init zsh)"

# VI Mode
set -o vi


source /home/rijkvp/.config/broot/launcher/bash/br
