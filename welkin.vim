set number
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'msanders/snipmate.vim'
Plugin 'The-NERD-tree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'mattn/emmet-vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"To do the same with the ctrl+s like others editor to save file 
"But you need to add 'stty -ixon' to the ~/.bashrc to save the 
"Comflict with the gnome-terminal
"The below is where you in the normal model
nmap <C-S> :w<CR>
"And this is when you in the visual model
vmap <C-S> <C-C>:w<CR>
"And this is when you in the insert model
"imap <C-S> <C-O>:w<CR>
"<C-O> back to the preview file position you did
imap <C-S> <ESC>:w<CR>
"Make the format of the code in insert model
nmap <F3> gg=G<CR>
imap <F3> <ESC> gg=G <CR>

"Make the undo in the insert mode
inoremap  <C-U> <ESC> u
"Make showcmd
set showcmd
"Make it more comfortable in the GUI version
set mouse=n
nmap <C-n> :tabnew<CR>
imap <C-n><ESC> :tabnew<CR>
" command mode to set the a-e to the line_head and end
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %


"use ; to replace :
" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

"This is ...Good!!!!
inoremap kj <Esc>
" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :
"modify the leader for the defualt \
let mapleader = ','
let g:mapleader = ','
" Zoom / Restore window.
function! s:ZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>


" To make the cursor center forever type zz or set scrolloff=999
set scrolloff=999
