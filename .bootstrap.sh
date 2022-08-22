#!/bin/sh

git clone --bare https://github.com/rijkvp/dotfiles.git $HOME/.dotfiles

alias dotf="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

dotf config status.showUntrackedFiles no
dotf checkout
