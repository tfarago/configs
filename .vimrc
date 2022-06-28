if has('vim_starting')
  set nocompatible               " Be iMproved
endif

"Plugin system{{{1

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins{{{2
call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'wincent/Command-T'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'flazz/vim-colorschemes'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'nanotee/zoxide.vim'
call plug#end()
"}}}2
"}}}1

"Editor{{{
map ' :
let mapleader = ","
set showmatch
set ruler
set noerrorbells
set history=1000
set wildmenu
set hidden
set pastetoggle=<F2>

set ignorecase
set smartcase

" Search related
set hlsearch
set wrapscan
set incsearch
nnoremap <silent><C-l> :<C-u>nohlsearch<CR><C-l>

set textwidth=80    " The standard drill
set autoindent      " ...
set tabstop=4       " Number of spaces per tab
set shiftwidth=4    " Default number of spaces for >> and <<
set softtabstop=4   " Number of spaces per tab
set expandtab       " Spaces instead of tabs
set smarttab        " Add/remove spaces instead of tabs
set linebreak       " Break lines nicer
set number          " Show line numbers
set backspace=indent,eol,start
set nostartofline

syntax on

if !has('gui_running')
  set t_Co=256
endif
"}}}

"Colors{{{
colorscheme mustang
" Highlight current line decently
hi CursorLine ctermbg=234 cterm=NONE
set cursorline

" Lightline
set laststatus=2
"}}}

"Completion{{{
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoTo<CR>
"}}}

"Useful mappings{{{
nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>
nnoremap <F5> <Esc>:w!<CR>:make!<CR><CR>
let c = 1
while c <= 9
    execute "nnoremap <Leader>" . c . " :" . c . "b<CR>"
    let c += 1
endwhile
"}}}

"Folding{{{
set foldmethod=marker
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"}}}
