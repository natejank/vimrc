let b:ale_linters = ['pyright', 'mypy']
let b:ale_fixers = ['black', 'isort']
let b:ale_fix_on_save = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_python_mypy_options = '--check-untyped-defs'

setlocal foldmethod=indent
setlocal foldlevel=100
