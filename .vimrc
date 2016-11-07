if has('vim_starting')
  set nocompatible               " Be iMproved

"NeoBundle{{{1
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
"Bundles{{{2
" My Bundles here:
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'wincent/Command-T'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'itchyny/lightline.vim' 
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'petRUShka/vim-opencl'
NeoBundle 'tpope/vim-surround'
"}}}2
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"}}}1

"Editor{{{
map ' :
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
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_disable_auto_complete = 1

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Use CTRL-space to popup completion menu 
inoremap <expr><Nul>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Disable docstrings to pop-up
set completeopt=menu
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
