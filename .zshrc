zstyle :compinstall filename '/home/rijkvp/.zshrc'

autoload -Uz compinit
compinit

########## 
# COLORS #
##########

# TODO


###########
# Aliases #
###########

alias ls='ls -1 --color=auto'
alias lsa='ls -1a --color=auto'

alias vim='nvim'
alias v='nvim'

alias s='systemctl'

# Gitk
alias gitcom='git add -A && git commit -a -m'

# Bare dotfiles git repo
alias cfg='/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'

# Start Starship
eval "$(starship init zsh)"
