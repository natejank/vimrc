let b:ale_linters = ['pyright', 'mypy', 'ruff']
let b:ale_fixers = ['black', 'isort']
let b:ale_fix_on_save = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_python_mypy_options = '--check-untyped-defs'
let g:ale_python_mypy_ignore_invalid_syntax = 1

setlocal foldmethod=indent
setlocal foldlevel=100
