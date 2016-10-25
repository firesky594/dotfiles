#!/usr/bin/env python
#!encoding: utf-8

cp -rf ./.tmux.conf ~/
if [ ! -d ~/.vim/bundle ] ; then 
  `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
fi
cp -rf ./.vimrc ~/
cp -rf ./welkin.vim ~/.vim/
cp -rf ./_.snippets ~/.vim/bundle/snipmate.vim/snippets/
