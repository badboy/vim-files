set title

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#infect()

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

set tabstop=2
set softtabstop=2
set shiftwidth=2
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
autocmd BufWritePre *.c,*.cpp,*.cc,*.h,*.rs :call StripTrailingWhitespaces()
autocmd BufWritePre *.rb,*.erl,*.tex,*.xml,*.java,*.js,*.php,*.pde,*.css,*.tpl,*.txt,PKGBUILD,*.ronn,*.hs,*.go,*.clj,*.py :call StripTrailingWhitespaces()
autocmd BufWritePre *.scss,*.erb,Rakefile,*.yml :call StripTrailingWhitespaces()
" make this function accessible
command! StripTrailing call StripTrailingWhitespaces()
command! Dot %s/\.  \([A-Z]\)/. \1/


"" delete trailing whitespace, but leave if more than one.
"" this enables <br>-style wrapping in markdown
function! StripTrailingWhitespacesMarkdown()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\(\S\)\s$/\1/e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre *.md,*.markdown :call StripTrailingWhitespacesMarkdown()

" Special handling for Markdown
function! <SID>PandocMarkdownFile()
    silent exec '!pdocm ' . shellescape(@%)
endfunction
autocmd BufWritePost *.m.md :call <SID>PandocMarkdownFile()

" format go before write
autocmd BufWritePre *.go Fmt


" C files
au FileType c,cpp,cuda let $MANSECT="3,2,7,5,1,8"
au FileType c,cpp,cuda,markdown set tabstop=4
au FileType c,cpp,cuda,markdown set softtabstop=4
au FileType c,cpp,cuda,markdown set shiftwidth=4
au FileType c,cpp set expandtab

au FileType go set tabstop=4
au FileType go set softtabstop=4
au FileType go set shiftwidth=4
au FileType go set noexpandtab

" Omnetpp files
au BufNewFile,BufRead *.ned set filetype=cpp
au BufNewFile,BufRead *.msg set filetype=cpp
au BufNewFile,BufRead Makefile* set filetype=make

au FileType php set comments=sl:/*,mb:*,elx:*/

"" erlang files
au FileType erlang setlocal foldmethod=manual

" Arduino source files are c++
au BufNewFile,BufRead *.pde set filetype=cpp
au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead Capfile set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby
au BufNewFile,BufRead *.arc,*.ops,*.jess set filetype=lisp
au BufNewFile,BufRead *pry* set filetype=ruby

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
" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/"

" enable :W, stupid typo
command! W w
command! Q q

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
"map \     :NERDTreeToggle<CR>

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
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py|(^|[/\\])doc($|[/\\])'
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0

nmap <leader>k :CtrlPBuffer<cr>
map <Leader>e :CtrlPClearCache<CR>

" from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" re-hardwrap paragraphs of text
nnoremap <leader>q gqip

map <F8> <plug>NERDTreeTabsToggle<CR>

" Make Ctrl-e/y go faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Sometimes F2 won't work, so use ,p
map <leader>p :set paste!<CR>

"set background=dark

map! <unique> <Leader>gh <Plug>GitHubLink

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


" more natural splitting
" via thoughtsbot
set splitbelow
set splitright

" http://vimcasts.org/episodes/soft-wrapping-text/
" Show … in front of wrapped line
set showbreak=\|

nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
nmap <Leader>t, :Tabularize /,\zs<CR>
vmap <Leader>t, :Tabularize /,\zs<CR>
nmap <Leader>t> :Tabularize /=><CR>
vmap <Leader>t> :Tabularize /=><CR>

nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

" show preview of markdown in w3m
au FileType markdown map <leader>o :w<CR>:!sundown %:p \| w3m -T text/html<CR><CR>

" relative numbers when needed
"set relativenumber
"autocmd InsertEnter,WinLeave * :set norelativenumber
"autocmd InsertLeave,WinEnter * :set relativenumber

nnoremap <Leader>z :LiteDFMToggle<CR>i<Esc>`^

let g:calendar_google_calendar = 1

" Sessions
" autosave on close
let g:session_autosave = 'yes'
" autosave every 30min
let g:session_autosave_periodic = 30
let g:session_autoload = 'no'

set sessionoptions-=help
set sessionoptions-=options

nnoremap <leader>m :ta 

let g:ackprg = 'ag --nogroup --nocolor --column'

" when joining lines, don't insert two spaces after punctuation
set nojoinspaces
" enable mouse clicking (now that the vim package has everything)
"set mouse=a

let g:racer_cmd = "/home/badboy/code/rust/racer/target/release/racer"
let $RUST_SRC_PATH="/home/badboy/code/rust/rust/src"
