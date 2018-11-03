#!/bin/bash

#Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


#Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#execute
find . -maxdepth 1 -type d -not -path '*/\.*' | grep -v '^\.$' | xargs stow
