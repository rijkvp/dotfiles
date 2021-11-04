zstyle :compinstall filename '/home/rijkvp/.zshrc'

autoload -Uz compinit
compinit

# Add to path
source ~/scripts/goto.sh
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts:$PATH

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

# Git
alias gitcom='git add -A && git commit -a -m'

# Bare dotfiles git repo
alias cfg='/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'

alias g='goto'

# Start Starship
eval "$(starship init zsh)"

