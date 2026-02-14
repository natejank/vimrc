let b:ale_linters = ['clangd', 'clang-tidy']
if exists('g:c_formatter')
    let b:ale_fixers = [g:c_formatter]
else
    let b:ale_fixers = ['clang-format']
endif

let b:ale_fix_on_save = exists('g:c_enable_format_on_save')

