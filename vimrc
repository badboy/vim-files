set nocompatible              " be iMproved, required
filetype off                  " required

if has("gui_running")
  set guifont=Monaco:h12
  set linespace=0
  let g:nerdtree_tabs_open_on_gui_startup = 0
endif

set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set noincsearch

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle')

Plug 'NLKNguyen/papercolor-theme'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tristen/vim-sparkup'
Plug 'mileszs/ack.vim'
Plug 'cespare/vim-toml'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'jtai/vim-githublink'
Plug 'tpope/vim-ragtag'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'udalov/kotlin-vim'
Plug 'rhysd/vim-clang-format'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'

call plug#end()

set title
syntax on          " Enable syntax highlighting
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

let mapleader = ","

" hide buffers instead of closing them
set hidden

" increase as decimals
" via https://lobste.rs/s/6qp0vo/at_least_one_vim_trick_you_might_not_know#c_duinox
set nrformats-=octal

set wrap " wrap lines
set tags^=.git/tags;~

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.rbc,*.class,*.hi,*.o,*.mmo,.git,.svn,.hg,*.xcodeproj,third_party

set pastetoggle=<F2>

" always show the status bar
set laststatus=2

set shell=/bin/zsh
set nu
set formatoptions-=o
set formatoptions+=r
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
" Disable folding completely
set nofoldenable

" make backspace work like in other programs
set backspace=indent,eol,start

" instead of :lcd %:p:h
" to change directories upon opening a file
"set autochdir

" set wildmenu on
set wmnu

" swap file directory
set directory^=~/.cache/vim/swap

" don't store .viminfo in $HOME
set viminfo+=n~/.cache/vim/viminfo

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
autocmd BufWritePre *.rb,*.erl,*.tex,*.xml,*.java,*.js,*.jsm,*.php,*.pde,*.css,*.tpl,*.txt,PKGBUILD,*.ronn,*.hs,*.go,*.clj,*.py,*.swift,*.lua :call StripTrailingWhitespaces()
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

" C files
au FileType c,cpp let $MANSECT="3,2,7,5,1,8"

au FileType markdown set tabstop=4
au FileType markdown set softtabstop=4
au FileType markdown set shiftwidth=4

au FileType kotlin set tabstop=4
au FileType kotlin set softtabstop=4
au FileType kotlin set shiftwidth=4

au FileType go set tabstop=4
au FileType go set softtabstop=4
au FileType go set shiftwidth=4
au FileType go set noexpandtab

au FileType java set tabstop=4
au FileType java set softtabstop=4
au FileType java set shiftwidth=4
au FileType java set expandtab

au FileType swift set tabstop=4
au FileType swift set softtabstop=4
au FileType swift set shiftwidth=4

au FileType cs set tabstop=4
au FileType cs set softtabstop=4
au FileType cs set shiftwidth=4

au BufNewFile,BufRead Capfile set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby
au BufNewFile,BufRead *pry* set filetype=ruby
au BufNewFile,BufRead *.lalrpop set filetype=rust
au BufNewFile,BufRead *.jsm set filetype=javascript

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <Leader><space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <s-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
" copy current path into the clipboard
nnoremap <silent> yp :!echo -n % \| pbcopy<CR><CR>

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

"set statusline+=%#warningmsg#
"set statusline+=%*
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

let g:NERDCustomDelimiters = {
      \ 'kotlin': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
      \ 'swift': { 'left': '///' }
  \}
