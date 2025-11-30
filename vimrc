" auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/editorconfig/editorconfig-vim'
call plug#end()

" settings
set number                             " use line numbers
filetype plugin indent on              " use per-filetype settings
syntax on                              " enable syntax highlighting
set tabstop=4                          " tabs display as 4 spaces
set shiftwidth=4                       " number of spaces to use for indent
set expandtab                          " use spaces instead of tabs
set smartindent                        " use smart indenting on new line
set backspace=indent,eol,start         " delete indentation
set smarttab                           " better tab and delete
set wildmenu                           " get a menu for tab-completing stuff
set mouse=a                            " mouse support in (a)ll modes
set ttymouse=sgr                       " the mouse which works over ssh
set splitright                         " vertical splits open on the right
set splitbelow                         " horizontal splits open below
set scrolloff=1                        " always leave 1 line below the cursor
set sidescrolloff=5                    " always leave 5 chrs right of cursor
set hidden                             " open more than 1 buffer simultaneously
set nomodeline                         " don't read arbitrary config from buffers
set ignorecase                         " ignore case by default
set smartcase                          " case-aware autocomplete
set incsearch                          " show match while searching/substituting
set hlsearch                           " show all results of a search
set autoread                           " detect when a file is modified
set nowrap                             " I hate line wrap!!
set nostartofline                      " maintain cursor position for move cmds
set showcmd                            " show partial chords as you enter them
set notimeout                          " don't timeout waiting for a chord
set ttimeout                           " configure a timeout for key codes
set ttimeoutlen=0                      " do not wait after input for a chord
                                       " this removes the delay after <esc>
set colorcolumn=80,120                 " column at 80, 120 chrs

colorscheme jellybeans
" keybindings - actions are on <space>
map <space> <nop>
let mapleader=" "
" clear search highlight
nnoremap <leader>n :nohl<cr>
map gcc :Commentary<cr>
vmap gc :Commentary<cr>
" move faster with less finger movement
nnoremap gl $
nnoremap gh 0
nnoremap gb ^
nnoremap j gj
nnoremap k gk
vnoremap gl $
vnoremap gh 0
vnoremap gb ^
" fzf bindings
map <leader>f :Files<cr>
map <leader>g :Rg<cr>
" map <leader>b :Buffers<cr>

set listchars=tab:>\ ,trail:-,nbsp:+,space:.
" augroup ShowTrailing
"     autocmd!
"     autocmd BufRead,InsertEnter * set nolist
"     autocmd BufRead,InsertLeave * set list
" augroup end

" create swap directory if it doesn't exists
silent exec '!mkdir -p $HOME/.cache/vim'
set directory=$HOME/.cache/vim//       " store swap files at ~/.cache/vim

" a little statusline I borrowed from the internet
" https://shapeshed.com/vim-statuslines/
" gets spaces/tabs setting and size
function! Indent() abort
    let l:tabtype=(&expandtab ? "Spaces" : "Tab")
    let l:tabsize=(&expandtab ? &shiftwidth : &tabstop)
    return  l:tabtype . ':' . l:tabsize
endfunction

" gets buffer encoding
function! Encoding() abort
    return (&fileencoding ? &fileencoding : &encoding)
endfunction

set laststatus=2                       " enable the statusline
set statusline=                        " clear the statusline
set statusline+=\                      " start padding
set statusline+=%F                     " whole path to filename
set statusline+=%m                     " modified
set statusline+=%=                     " left/right separation
set statusline+=%{Indent()}            " Indentation
set statusline+=\ %y                   " filetype
set statusline+=\ %{Encoding()}        " get encoding
set statusline+=\ \[%{&fileformat}\]   " line ending (unix/windows)
set statusline+=\ %p%%                 " file percentage
set statusline+=\ %l:%c                " line:column
set statusline+=\                      " end padding

