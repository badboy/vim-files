set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" Incremental (“live”) :substitute
" via https://neovim.io/news/2016/11/
set inccommand=split
