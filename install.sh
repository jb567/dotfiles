#!/bin/bash

#execute symlinks
find . -maxdepth 1 -type d -not -path '*/\.*' -not -name 'installers' | grep -v '^\.$' | xargs stow


#Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl https://git.io/fisher --create-dirs -sLo \
    ~/.config/fish/functions/fisher.fish
