set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'NLKNguyen/papercolor-theme'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'badboy/tslime.vim'
Plugin 'tpope/vim-rails'
Plugin 'ngmy/vim-rubocop'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'shemerey/vim-project'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/cecutil'
Plugin 'Lokaltog/vim-powerline'
Plugin 'msanders/snipmate.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'edsono/vim-matchit'
Plugin 'bilalq/lite-dfm'
Plugin 'tpope/vim-rbenv'
Plugin 'vim-scripts/DrawIt'
Plugin 'vim-scripts/simplefold'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'tristen/vim-sparkup'
Plugin 'mileszs/ack.vim'
Plugin 'cespare/vim-toml'
Plugin 'itchyny/calendar.vim'
Plugin 'xolox/vim-session'
Plugin 'vim-pandoc/vim-pandoc-after'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'chase/vim-ansible-yaml'
Plugin 'davidoc/taskpaper.vim'
Plugin 'jtai/vim-githublink'
Plugin 'fatih/vim-go'
Plugin 'elixir-lang/vim-elixir'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-ragtag'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
"Plugin 'wincent/command-t'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/clam.vim'
Plugin 'valloric/YouCompleteMe'
"Plugin 'mhinz/vim-startify'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()
filetype plugin indent on

set title
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
nmap <Leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

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

au FileType java set tabstop=4
au FileType java set softtabstop=4
au FileType java set shiftwidth=4
au FileType java set expandtab

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
nmap <Leader>s  :%s/
vmap <Leader>s  :s/"

" enable :W, stupid typo
command! W w
command! Q q

" disable highlights of last search
"imap <F2> <C-O><F2>
"map <silent><F2> :nohlsearch<CR>
nmap <silent> <Leader><space> :set hlsearch!<CR>

" simple switch for cursor{line,column}
imap <F4> <C-O><F4>
imap <F5> <C-O><F5>
map <silent><F4> :set invcursorline<CR>
map <silent><F5> :set invcursorcolumn<CR>

" apply rot13 for people snooping over shoulder, good fun
map ,8 <ESC>ggg?G``

nmap <F9> :TagbarToggle<CR>
map <F10> :tabnew <CR>

" Easy split window navigation
" use ALT+ArrowKeys to switch split windows
nmap <silent> <A-Up>    :wincmd k<CR>
nmap <silent> <A-Down>  :wincmd j<CR>
nmap <silent> <A-Left>  :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

cmap w!! w !sudo tee % > /dev/null

nnoremap j gj
nnoremap k gk

nnoremap <Leader>a :Ack 

" no one needs help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ,, switches between two last buffers
nnoremap <Leader><Leader> <c-^>

" provide some context when editing
set scrolloff=3

" http://mislav.uniqpath.com/2011/12/vim-revisited/
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Do not clear the cache, ctrlp!
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py|(^|[/\\])(target|_site)($|[/\\])'
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0

nnoremap <Leader>k :CtrlPBuffer<cr>
nnoremap <Leader>e :CtrlPClearCache<CR>
"nnoremap <C-p> :CommandT<cr>
"nnoremap <Leader>k :CommandTBuffer<cr>
"nnoremap <Leader>e :CommandTFlush<CR>

"set wildignore+=target
"set wildignore+=_site

"let g:CommandTMaxHeight = 10
"let g:CommandTMatchWindowReverse = 1
"let g:CommandTHighlightColor = 'PmenuSel'


" from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" re-hardwrap paragraphs of text
nnoremap <Leader>q gqip

map <F8> <plug>NERDTreeTabsToggle<CR>

" Make Ctrl-e/y go faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Sometimes F2 won't work, so use ,p
map <Leader>p :set paste!<CR>

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

set t_Co=256
set background=dark
colorscheme PaperColor

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
match OverLength /\%>100v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>100v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

" show preview of markdown in w3m
au FileType markdown map <Leader>o :w<CR>:!sundown %:p \| w3m -T text/html<CR><CR>

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

nnoremap <Leader>m :ta 

let g:ackprg = 'ag --nogroup --nocolor --column'

" when joining lines, don't insert two spaces after punctuation
set nojoinspaces
" enable mouse clicking (now that the vim package has everything)
"set mouse=a

let g:ycm_rust_src_path = "/home/jer/code/rust/rust/src"
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py', '!*']
let g:ycm_server_python_interpreter = 'python'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_include_dirs = [ './deps/hiredis' ]
let g:syntastic_c_compiler_options = ' -std=c99'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_rst_rst2pseudoxml_quiet_messages = { "level": "error" }
let g:syntastic_javascript_checkers = []
let g:syntastic_tex_checkers = []
let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = ['python2']
let g:syntastic_quiet_messages = { "level": "warning" }

let g:pandoc#spell#enabled = 0

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}
