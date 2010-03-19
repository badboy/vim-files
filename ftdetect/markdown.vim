" Markdown
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown
au FileType markdown set tabstop=2
au FileType markdown set softtabstop=2
au FileType markdown set shiftwidth=2
au FileType markdown set expandtab

" show preview of markdown in w3m
au FileType markdown map <leader>p :w<CR>:!rdiscount %:p \| w3m -T text/html<CR><CR>
