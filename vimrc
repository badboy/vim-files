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
set wildignore=*.swp,*.bak,*.pyc,*.rbc,*.class,*.hi,*.o,*.mmo,.git,.svn
" ignore .git for ctrlp.vim
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX
set wildignore+=*/temp/templates_c/*

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
function! StripTrailingWhitespaces()
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
autocmd BufWritePre *.c,*.rb,*.erl,*.tex,*.xml,*.java,*.js,*.php,*.pde,*.css,*.tpl,*.md,*.txt,PKGBUILD,*.ronn,*.markdown,*.hs :call StripTrailingWhitespaces()
autocmd BufWritePre *.scss,*.erb :call StripTrailingWhitespaces()

function! <SID>PandocMarkdownFile()
    silent exec '!pdocm ' . shellescape(@%)
endfunction
autocmd BufWritePost *.m.md :call <SID>PandocMarkdownFile()


"" C files
au FileType c let $MANSECT="3,2,7,5,1,8"
au FileType c set tabstop=4
au FileType c set softtabstop=4
au FileType c set shiftwidth=4
au FileType c set expandtab

au FileType php set comments=sl:/*,mb:*,elx:*/

"" LaTex Compile //& Open -
"au FileType tex nnoremap Y :w<Enter>:!rake && xpdf %<.pdf<Enter>
au FileType tex nnoremap Y :w<CR>:!rake<CR>

"" erlang files
au FileType erlang setlocal foldmethod=manual

" Arduino source files are c++
au BufNewFile,BufRead *.pde set filetype=cpp
au BufNewFile,BufRead *.tpl set filetype=smarty.html
au BufNewFile,BufRead Capfile set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby

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

" enable :W, stupid typo
command! W w

" disable highlights of last search
"imap <F2> <C-O><F2>
"map <silent><F2> :nohlsearch<CR>
nmap <silent> <leader><space> :set hlsearch!<CR>

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
map \     :NERDTreeToggle<CR>

" Easy split window navigation
" use ALT+ArrowKeys to switch split windows
nmap <silent> <A-Up>    :wincmd k<CR>
nmap <silent> <A-Down>  :wincmd j<CR>
nmap <silent> <A-Left>  :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

cmap w!! w !sudo tee % > /dev/null

nnoremap j gj
nnoremap k gk

nnoremap <leader>a :Ack 

" no one needs help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ,, switches between two last buffers
nnoremap <leader><leader> <c-^>

" provide some context when editing
set scrolloff=3

" http://mislav.uniqpath.com/2011/12/vim-revisited/
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>d "=strftime("# %Y-%m-%d")<CR>Po

" Do not clear the cache, ctrlp!
"let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0

" from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" re-hardwrap paragraphs of text
nnoremap <leader>q gqip

"set colorcolumn=85
"set relativenumber

"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>

map <F8> <plug>NERDTreeTabsToggle<CR>

" Make Ctrl-e/y go faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Sometimes F2 won't work, so use ,p
map <leader>p :set paste!<CR>

" Sometimes F3 won't work, so use ,k
nmap <leader>k :CtrlPBuffer<cr>

"set background=dark

function! GithubLink() range
    let l:giturl = system('git config remote.origin.url')
    let l:prefix = substitute(system('git rev-parse --show-prefix'), "\n", '', '')
    let l:repo = get(split(matchstr(l:giturl, '\w\+\/[_-a-zA-Z0-9]\+\.git'), '\.'), 0)
    let l:url = 'https://github.com/' . l:repo
    let l:branch = get(split(substitute(system('git symbolic-ref HEAD'), "\n", '', '') , '/'), -1)
    let l:filename = l:prefix . @%

    let l:full = join([l:url, 'blob', l:branch, l:filename], '/')

    let l:complete = l:full . '#L' . a:firstline . '-' . a:lastline

    echo l:complete
endfunction

noremap <Leader>gh :call GithubLink()<CR>

function! NewScratchBuffer()
  split
  enew
  resize 10
  set buftype=nofile
  set bufhidden=hide
  setlocal noswapfile
endfunction

map <Leader>b :call NewScratchBuffer()<CR>
" Move to next function using mm
map mm ]m

map <Leader>e :CtrlPClearCache<CR>

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/"

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

set background=dark

function! s:Move(cmd, count, map) abort
    normal! m`
    exe 'move'.a:cmd.a:count
    norm! ``
    silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

nnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
xnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>exe 'normal! m`'<Bar>exe '''<,''>move--'.v:count1<CR>``
xnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'normal! m`'<Bar>exe '''<,''>move''>+'.v:count1<CR>``

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveUp
xmap ]e <Plug>unimpairedMoveDown

" move text left and right
"nmap <Left> <<
"nmap <Right> >>
"vmap <Left> <gv
"vmap <Right> >gv

"" move text up and down
"nmap <Up> [e
"nmap <Down> ]e
"vmap <Down> ]egv
"vmap <Up> [egv
