#!/usr/bin/env python
#!encoding: utf-8
#!/bin/bash

cp -rf ./.tmux.conf ~/
if [ ! -d ~/.vim/bundle ] ; then 
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
cp -rf ./.vimrc ~/
cp -rf ./welkin.vim ~/.vim/
echo "准备安装插件"
vim -c PluginInstall  -c quitall
cp -rf ./_.snippets ~/.vim/bundle/snipmate.vim/snippets/


# The shell setting
echo "export TERM=xterm-256color" >> ~/.bashrc
source ~/.bashrc
