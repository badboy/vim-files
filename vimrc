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
Plugin 'xolox/vim-session'
Plugin 'vim-pandoc/vim-pandoc-after'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'chase/vim-ansible-yaml'
Plugin 'jtai/vim-githublink'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-ragtag'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/clam.vim'
Plugin 'valloric/YouCompleteMe'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'reedes/vim-colors-pencil'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'rhysd/rust-doc.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

call vundle#end()

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
set wildignore=*.swp,*.bak,*.pyc,*.rbc,*.class,*.hi,*.o,*.mmo,.git,.svn,.hg

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

" make backspace work like in other programs
set backspace=indent,eol,start

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
let g:gist_clip_command = 'pbcopy'
" open browser!
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL%'

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
autocmd BufWritePre *.rst :call StripTrailingWhitespaces()
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
au FileType c,cpp let $MANSECT="3,2,7,5,1,8"

au FileType markdown set tabstop=4
au FileType markdown set softtabstop=4
au FileType markdown set shiftwidth=4

au FileType go set tabstop=4
au FileType go set softtabstop=4
au FileType go set shiftwidth=4
au FileType go set noexpandtab

au FileType java set tabstop=4
au FileType java set softtabstop=4
au FileType java set shiftwidth=4
au FileType java set expandtab

au BufNewFile,BufRead Capfile set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby
au BufNewFile,BufRead *pry* set filetype=ruby
au BufNewFile,BufRead *.lalrpop set filetype=rust
au BufNewFile,BufRead *.jsm set filetype=javascript

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
command! Qa qa
cnoremap <expr> X (getcmdtype() is# ':' && empty(getcmdline())) ? 'x' : 'X'

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

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" open quickfix window using ,w
nnoremap <Leader>w :call ToggleList("Quickfix List", 'c')<cr>
nnoremap <Leader>v :lclose<cr>

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

let g:fzf_command_prefix = 'Fzf'
nnoremap <C-p> :FZF<cr>
nnoremap <Leader>k :FzfBuffer<cr>

"set wildignore+=target
"set wildignore+=_site

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

" Sessions
" autosave on close
let g:session_autosave = 'yes'
" autosave every 30min
let g:session_autosave_periodic = 30
let g:session_autoload = 'no'

set sessionoptions-=help
set sessionoptions-=options

nnoremap <Leader>m :ta 

let g:ackprg = 'rg -S --vimgrep --'

" when joining lines, don't insert two spaces after punctuation
set nojoinspaces
" enable mouse clicking (now that the vim package has everything)
"set mouse=a

let g:ycm_rust_src_path = "/home/jer/code/rust/rust/src"
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py', '/Users/jrediger/mozilla/src/mozilla-central/.ycm_extra_conf.py', '/Users/jrediger/mozilla/src/gecko/.ycm_extra_conf.py', '!*']
let g:ycm_server_python_interpreter = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_rst_rst2pseudoxml_quiet_messages = { "level": "error" }
let g:syntastic_python_checkers = ['python']
let g:syntastic_quiet_messages = { "level": "warning" }
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['scss','java','tex','javascript'] }

let g:pandoc#spell#enabled = 0

let g:tagbar_left = 1
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

" disable Shift-K. I almost never need it, pressing it only by accident
map <S-k> <Nop>

let g:rust_doc#downloaded_rust_doc_dir = "~/.rustup/toolchains/stable-x86_64-apple-darwin"
