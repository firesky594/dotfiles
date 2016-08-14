"Something settings
let NERDTreeShowHidden=1
map <F2> :NERDTreeToggle<CR>
"Something wrongs
"To rescue the Taglist: Exuberant ctags (http://ctags.sf.net) not found in PATH. Plugin is not loaded
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"Text search and replace
set showcmd
set showmatch
set matchtime=2
set hlsearch
set incsearch
set ignorecase 
set smartcase
set magic
set lazyredraw
set nowrapscan
set iskeyword+=_,$,@,%,#,-,.
" Somethings settings
set tabstop=2
set shiftwidth=2
set smarttab
"set number
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
"
"This is the test module of my hobby to vim
if filereadable(expand("~/.vim/welkin.vim"))
	so ~/.vim/welkin.vim
endif

