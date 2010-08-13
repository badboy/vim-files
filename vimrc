set nocompatible " We're running Vim, not Vi!
set title

set shell=/bin/zsh
set nu
set formatoptions-=o
set ignorecase
set smartcase
set ruler                " show me where the cursor is
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
" by default
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
let g:gist_browser_command = 'firefox %URL% &'

syntax on " Enable syntax highlighting
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins
compiler ruby " Enable compiler support for ruby

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
autocmd BufWritePre *.c,*.rb,*.erl,*.tex,*.xml :call <SID>StripTrailingWhitespaces()

"" C files
au FileType c let $MANSECT="3,2,7,5,1,8"
au FileType c set tabstop=8
au FileType c set softtabstop=8
au FileType c set shiftwidth=8
au FileType c set expandtab

"" LaTex Compile //& Open -
"au FileType tex nnoremap Y :w<Enter>:!rake && xpdf %<.pdf<Enter>
au FileType tex nnoremap Y :w<CR>:!rake<CR>

"" markdown files
"au BufRead,BufNewFile *.markdown   setfiletype markdown

"" erlang files
au FileType erlang setlocal foldmethod=manual

"" PKGBUILD files
au BufEnter PKGBUILD nested imap <F6>  <C-O>mt<C-O>gg<C-O>/^[
            \t]*md5sums=/<CR><C-O>0<C-O>vf(%d<C-O>dd<C-O>k<C-O>:r!makepkg -g 2>/dev/null<CR><C-O>:nohlsearch<CR><C-O>`t|
                              \ map <silent><F6> mtgg/^[
            \t]*md5sums=/<CR>0vf(%dddk:r!makepkg -g 2>/dev/null<CR>:nohlsearch<CR>`t

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" enable :W
command W w
" disable highlights of last search
imap <F2> <C-O><F2>
map <silent><F2> :nohlsearch<CR>
" simple switch for cursor{line,column}
imap <F4> <C-O><F4>
imap <F5> <C-O><F5>
map <silent><F4> :set invcursorline<CR>
map <silent><F5> :set invcursorcolumn<CR>
" apply rot13 for people snooping over shoulder, good fun
map <F8> <ESC>ggg?G``

map <F9> :TlistToggle <CR>
map <F10> :tabnew <CR>
map <F12> :NERDTreeToggle<CR>
map <leader>t :FufFile<CR>

" Easy split window navigation
" use ALT+ArrowKeys to switch split windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" use C-[hjkl] instead
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
"nmap ,s :source $MYVIMRC
"nmap ,v :e $MYVIMRC

"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
