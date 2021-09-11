#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Provide a path to home directory"
    exit 1
fi

HOME_DIR="$1"

ln -s $HOME_DIR/.rcs/gitconfig $HOME_DIR/.gitconfig
ln -s $HOME_DIR/.rcs/vimrc $HOME_DIR/.vimrc
ln -s $HOME_DIR/.rcs/mc_ini $HOME_DIR/.config/mc/ini
git config --global core.excludesfile $HOME_DIR/.rcs/gitignore

touch $HOME_DIR/.bashrc
echo "source $HOME_DIR/.rcs/bashrc" >> $HOME_DIR/.bashrc
