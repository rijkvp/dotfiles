zstyle :compinstall filename '/home/rijkvp/.zshrc'

autoload -Uz compinit
compinit

# Add to path
export PATH=$HOME/.local/bin:$PATH

source ~/scripts/goto.sh

########## 
# COLORS #
##########

# TODO


###########
# Aliases #
###########
alias ls='exa'
alias lsa='exa -a'

alias vim='nvim'
alias v='nvim'

alias s='systemctl'

# Gitk
alias gitcom='git add -A && git commit -a -m'

# Bare dotfiles git repo
alias cfg='/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'

alias g='goto'

# Start Starship
eval "$(starship init zsh)"

neofetch
