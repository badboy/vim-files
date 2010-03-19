autocmd BufNewFile,BufRead *.mustache setf mustache
autocmd FileType mustache call RagtagInit()
