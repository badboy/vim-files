" Markdown
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown

" show preview of markdown in w3m
map <leader>p :w<CR>:!rdiscount %:p \| w3m -T text/html<CR><CR>
