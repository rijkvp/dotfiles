#!/bin/sh

git config --global credential.helper store
git clone --bare https://github.com/rijkvp/dotfiles.git $HOME/.dotfiles

function dotfiles {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles"
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup"
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
dotfiles checkout
dotfiles config status.showUntrackedFiles no
