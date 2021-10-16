#!/bin/bash

HOME_DIR=$(echo ~)

rm -rf $HOME_DIR/.gitconfig $HOME_DIR/.vimrc $HOME_DIR/.config/mc/ini

ln -s $HOME_DIR/.rcs/gitconfig $HOME_DIR/.gitconfig
ln -s $HOME_DIR/.rcs/vimrc $HOME_DIR/.vimrc
ln -s $HOME_DIR/.rcs/mc_ini $HOME_DIR/.config/mc/ini
git config --global core.excludesfile $HOME_DIR/.rcs/gitignore

touch $HOME_DIR/.bashrc
echo "source $HOME_DIR/.rcs/bashrc" >> $HOME_DIR/.bashrc
