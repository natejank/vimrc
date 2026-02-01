let b:ale_linters = ['clangd', 'clang-tidy']
if exists('g:c_formatter')
    let b:ale_fixers = [g:c_formatter]
else
    let b:ale_fixers = ['clang-format']
endif
let b:ale_fix_on_save = 1
