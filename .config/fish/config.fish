set fish_greeting
########## 
# COLORS #
##########
# See: https://fishshell.com/docs/current/interactive.html#variables-color
set fish_color_normal '#e5e9f0'
set fish_color_autosuggestion '#7d7d7d'

set fish_color_command '#81a1c1'
set fish_color_param '#a3be8c'
set fish_color_quote '#ebcb8b'

set fish_color_error '#bf616a'

###########
# Aliases #
###########

alias ls='ls --color=auto'

alias vim='nvim'
alias v='nvim'

alias s='systemctl'

# Gitk
alias gitcom='git add -A && git commit -a -m'

# Bare dotfiles git repo
alias cfg '/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'

# Start Starship
starship init fish | source
