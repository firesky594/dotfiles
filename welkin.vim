" ======================= default config ===================== "
set number
" To reset the tab and shift 
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
"Make showcmd
set showcmd
"Make it more comfortable in the GUI version
set mouse=n
" ====================== plugin config ======================= "
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' " plugin Tools
"Plugin 'altercation/vim-colors-solarized' "colorscheme
"Plugin 'lifepillar/vim-solarized8'
"Plugin 'Valloric/YouCompleteMe' " Look Good but not work for me
Plugin 'posva/vim-vue'
Plugin 'msanders/snipmate.vim' " Snipmate
Plugin 'The-NERD-tree' " FileTree
Plugin 'ctrlpvim/ctrlp.vim' " C-p to find the file
Plugin 'vim-scripts/taglist.vim' "Taglist
Plugin 'mattn/emmet-vim' " The Html quickly snippet
Plugin 'mileszs/ack.vim' " Alternative grep for programmers
" Colorscheme Theme
" markdown test
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =========================== advanced config ========================== "
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
" tabview  
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0 10gt
nmap <leader>n gt
nmap <leader>m gT
nmap <C-n> :tabnew<CR>
imap <C-n><ESC> :tabnew<CR>
" command mode to set the a-e to the line_head and end
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Make the command to see
set showcmd
"Make the autocmd to mkview and loadview
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview 
" Save fold settings.
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options

"This is ...Good!!!!
inoremap kj <Esc>
"use ; to replace :
" 复制选中区到系统剪切板中
vnoremap <leader>y "+y
map <leader>y "+y

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
"But it is not suit to the copy mode when use cursor select
"set scrolloff=5

"remap U to <C-r> 
nnoremap U <C-r>


"define the header for the *.py | *.sh | .etc
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
	endif

	if &filetype == 'py'
		call append("\#!/usr/bin/env python")
		call append("\#!encoding: utf-8")
	endif

	normal G
	normal o
	normal o
endfunc
" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
	  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"resize the window quickly 
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
"resize the window right or left
nnoremap <silent> <Leader>< :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>> :exe "vertical resize -10"<CR>
""""""""""""""""""""""""""""""
" showmarks setting
""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1

" NERDTree setting 
" auto change the pwd to current floder
" autocmd vimenter * silent! :NERDTreeFind<CR>
autocmd vimenter * silent! lcd %:p:h
map <leader>r :NERDTreeFind<CR>

" vim-multiple-cursors setting
"let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-l>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" move line up/donw like sublime 
function! s:swap_lines(n1, n2)
	let line1 = getline(a:n1)
	let line2 = getline(a:n2)
	call setline(a:n1, line2)
	call setline(a:n2, line1)
endfunction

function! s:swap_up()
	let n = line('.')
	if n == 1
		return
	endif

	call s:swap_lines(n, n - 1)
	exec n - 1
endfunction

function! s:swap_down()
	let n = line('.')
	if n == line('$')
		return
	endif

	call s:swap_lines(n, n + 1)
	exec n + 1
endfunction

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>

" copy the text from vim to clipboard
" yank and paste
set clipboard=unnamedplus
set clipboard=unnamed
nmap <leader>c "+y
nmap <leader>v "+gp

" set the currnt line to hightlight
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
" source colorshceme if exist

" set the color for the vim 
" from 2017/4/20 the vim will be the main editor for me at home
set background=dark
hi CursorLine term=none cterm=none ctermbg=none
hi Normal ctermfg=252 ctermbg=none
set t_Co=256 "some case you need to `export TERM='xterm-256color'` for your terminal


" vim-vue Plugin Setting
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

