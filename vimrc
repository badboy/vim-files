set nocompatible " We're running Vim, not Vi!
set title

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

if exists('g:loaded_fugitive') || &cp
  set statusline=%<%f\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-17.(%l/%L(%p%%),%c%)
endif

syntax on          " Enable syntax highlighting
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

let mapleader = ","

" hide buffers instead of closing them
set hidden

set wrap " wrap lines

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.rbc,*.class

set pastetoggle=<F2>

" always show the status bar
set laststatus=2

set shell=/bin/zsh
set nu
set formatoptions-=o
set ignorecase
set smartcase
set gdefault                   " applies substitutions globally on lines (like /g)
set ruler                      " show me where the cursor is
set rulerformat=%l/%L(%p%%),%c " a better ruler
"set hlsearch
set visualbell
set noerrorbells
set t_vb=

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" instead of :lcd %:p:h
" to change directories upon opening a file
"set autochdir

" set wildmenu on
set wmnu

" swap file directory
set directory^=~/.vim/swap

" don't store .viminfo in $HOME
set viminfo+=n~/.vim/viminfo

" enable display of invisible whitespace
set list
" toggle invisible whitespace display
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

colorscheme vibrantink

" nnoremap F :w<Enter>:colorscheme vibrantink<Enter>

" for use with :Gist
"" clipboard fix
let g:gist_clip_command = 'xclip -selection clipboard'
" open browser!
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'chromium %URL% &'

" autocmd
"" delete trailing whitespace on save
"" via http://gist.github.com/227361 (defunkt)
"" and
"" http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre *.c,*.rb,*.erl,*.tex,*.xml,*.java,*.js,*.php,*.pde :call <SID>StripTrailingWhitespaces()

"" C files
au FileType c let $MANSECT="3,2,7,5,1,8"
au FileType c set tabstop=8
au FileType c set softtabstop=8
au FileType c set shiftwidth=8
au FileType c set expandtab

"" LaTex Compile //& Open -
"au FileType tex nnoremap Y :w<Enter>:!rake && xpdf %<.pdf<Enter>
au FileType tex nnoremap Y :w<CR>:!rake<CR>

"" erlang files
au FileType erlang setlocal foldmethod=manual

"" PKGBUILD files
"" needs cleanup, maybe own file?
au BufEnter PKGBUILD nested imap <F6>  <C-O>mt<C-O>gg<C-O>/^[
            \t]*md5sums=/<CR><C-O>0<C-O>vf(%d<C-O>dd<C-O>k<C-O>:r!makepkg -g 2>/dev/null<CR><C-O>:nohlsearch<CR><C-O>`t|
                              \ map <silent><F6> mtgg/^[
            \t]*md5sums=/<CR>0vf(%dddk:r!makepkg -g 2>/dev/null<CR>:nohlsearch<CR>`t

" Arduino source files are c++
au BufNewFile,BufRead *.pde set filetype=cpp

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<CR>

" fix Vim's horribly broken default regex “handling”
nnoremap / /\v
vnoremap / /\v

" enable :W
" stupid typo
command! W w

" disable highlights of last search
"imap <F2> <C-O><F2>
"map <silent><F2> :nohlsearch<CR>
nmap <silent> <leader><space> :nohlsearch<CR>

" simple switch for cursor{line,column}
imap <F4> <C-O><F4>
imap <F5> <C-O><F5>
map <silent><F4> :set invcursorline<CR>
map <silent><F5> :set invcursorcolumn<CR>

" apply rot13 for people snooping over shoulder, good fun
map ,8 <ESC>ggg?G``

map <F9>  :TlistToggle <CR>
map <F10> :tabnew <CR>
map <F12> :NERDTreeToggle<CR>

" Easy split window navigation
" use ALT+ArrowKeys to switch split windows
nmap <silent> <A-Up>    :wincmd k<CR>
nmap <silent> <A-Down>  :wincmd j<CR>
nmap <silent> <A-Left>  :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

cmap w!! w !sudo tee % > /dev/null

nnoremap j gj
nnoremap k gk

" no one needs help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
