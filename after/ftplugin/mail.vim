command! -nargs=1 -complete=file AttachFile exe "normal ma6gg" | call append(line('.'), 'Attach: <args>') | normal `a
