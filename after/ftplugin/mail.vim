command! -nargs=1 -complete=file AttachFile exe "normal magg}-" | call append(line('.'), 'Attach: <args>') | normal `a
