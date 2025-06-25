set nocompatible

filetype off

set clipboard=unnamedplus

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'

set tabstop=2

set shiftwidth=2

set autoindent

set expandtab

syntax on

filetype plugin on

set path+=**

set wildmenu

set number

set cursorline
:highlight Cursorline cterm=bold ctermbg=black

set hlsearch

set incsearch

set smartcase

set ignorecase

inoremap jk <Esc>

set smartcase

" set showmatch

if !has('gui_running')
  set t_Co=256
endif

" set termguicolors

set autoread
au FocusGained,BufEnter * checktime

set wildmenu

set ruler

" set foldcolumn=1

set laststatus=2

set relativenumber

set mouse=a

set title

" set spell

Plugin 'tpope/vim-surround'

call vundle#end()   
filetype plugin indent on    
