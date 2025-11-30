" auto-install vim-plug
"
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
"
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
Plug 'https://github.com/editorconfig/editorconfig-vim'
call plug#end()

" Editor settings
"
" Use line numbers
set number
" Enable syntax highlighting
filetype plugin indent on
" tabs display as 4 spaces
set tabstop=4
" use 4 spaces per indent
set shiftwidth=4
" use spaces instead of tabs
set expandtab
" autodetect indent size
set smartindent
" delete indentation on backspace
set backspace=indent,eol,start
" get more intelligent tab and delete behavior
set smarttab
" get tab-completion for : menu
set wildmenu
" enable the mouse
set mouse=a
set ttymouse=sgr
" configure splits
set splitright
set splitbelow
" configure scrolling
set scrolloff=1
set sidescrolloff=5
" allow more than one buffer to remain in memory
set hidden
" don't read modeline from files
" set nomodeline
" ignore case when searching
set ignorecase
" make search optionally case-aware
set smartcase
" show results when searching
set incsearch
" show all results when searching
set hlsearch
" reload the file when modified
set autoread
" disable line wrap
set nowrap
" maintain vertical position when changing lines
set nostartofline
" show incomplete keyboard chords
set showcmd
" no timeout on keyboard chords
set notimeout
" disable delay after <esc>
set ttimeout
set ttimeoutlen=0
" configure vertical column
set colorcolumn=80,120

" keybindings - actions are on <space>
map <space> <nop>
let mapleader=" "
" clear search highlight
nnoremap <leader>n :nohl<cr>
map gcc :Commentary<cr>
vnoremap gc :Commentary<cr>
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

