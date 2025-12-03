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
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/dense-analysis/ale'
Plug 'https://github.com/prabirshrestha/asyncomplete.vim'
Plug 'https://github.com/airblade/vim-gitgutter'
call plug#end()

" ale settings
let g:ale_enabled = 1
let g:ale_completion_enabled=0
let g:ale_fixers = {'*': ['trim_whitespace', 'remove_trailing_lines']}
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%: %severity%] %s'
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_completion_max_suggestions = 500
let g:ale_lint_delay = 40
" let g:ale_fix_on_save = 1

" asyncomplete
au User asyncomplete_setup call asyncomplete#register_source(
\   asyncomplete#sources#ale#get_source_options({
\       'priority': 10,
\   })
\)
" show preview for imports/includes
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" colorscheme!
colorscheme jellybeans

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
set signcolumn=yes                     " enable the gutter left of the numbers
set updatetime=100                     " lower delay of disk sync operations

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" fzf bindings
map <leader>f :Files<cr>
map <leader><leader> :GFiles<cr>
map <leader>g :Rg<cr>
map <leader>b :Buffers<cr>
" lsp bindings
map gd :ALEGoToDefinition<cr>
map gr :ALEFindReferences<cr>
map K :ALEHover<cr>
map <C-i> :pclose<cr>
map <leader>ca :ALECodeAction<cr>
map <leader>cr :ALERename<cr>
map <leader>cfr :ALEFileRename<cr>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

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

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set laststatus=2                       " enable the statusline
set statusline=                        " clear the statusline
set statusline+=\                      " start padding
set statusline+=%F                     " whole path to filename
set statusline+=%m                     " modified
set statusline+=\                      " padding before linting
set statusline+=%{LinterStatus()}      " ALE status
set statusline+=%=                     " left/right separation
set statusline+=%{Indent()}            " Indentation
set statusline+=\ %y                   " filetype
set statusline+=\ %{Encoding()}        " get encoding
set statusline+=\ \[%{&fileformat}\]   " line ending (unix/windows)
set statusline+=\ %p%%                 " file percentage
set statusline+=\ %l:%c                " line:column
set statusline+=\                      " end padding

