" Vim plugin for searchfox integration
" Maintainer: Jan-Erik Rediger <jrediger@mozilla.com>
" License: MIT License

if exists("searchfoxlink_loaded")
  finish
endif
let searchfoxlink_loaded = 1

if !exists("g:searchfoxlink_mode")
  " Test to see if pbcopy is available
  silent !pbcopy -help 2> /dev/null
  if !v:shell_error
    let g:searchfoxlink_mode = "pbcopy"
  else
    let g:searchfoxlink_mode = "echo"
  endif
endif

" Change directories to the directory of the file we're editing, then execute a command
function s:Cd(command)
  let output = system("cd " . shellescape(expand("%:p:h")) . " && " . a:command)
  if v:shell_error
    return ""
  endif
  return output
endfunction

" Get the root directory of the current repository
function s:GitRoot()
  let root = s:Cd("git rev-parse --show-toplevel")
  let root = substitute(root, "\n$", "", "")
  return root
endfunction

function s:BaseUrl()
  return "https://searchfox.org/mozilla-central/source"
endfunction

" Called when key binding is activated
function s:Main()
  let path = expand("%:p")
  if empty(path)
    echohl Error | echo "No file name" | echohl Normal
    return
  endif

  let root = s:GitRoot()
  if empty(root)
    echohl Error | echo "Not a git repository" | echohl Normal
    return
  endif

  let url = s:BaseUrl() . substitute(path, "^" . root, "", "") . "#" . line(".")
  if g:searchfoxlink_mode == "pbcopy"
    " Copy URL to clipboard with pbcopy and echo a status message
    call system("pbcopy", url)
    echo "\"" . url . "\" copied to clipboard"
  elseif g:searchfoxlink_mode == "echo"
    echo url
  else
    echohl Error | echo "g:searchfoxlink_mode not set" | echohl Normal
  endif
endfunction

" Type backslash h in command mode to display the searchfox.com URL of the current line
if !hasmapto("<Plug>searchfoxlink")
  map <unique> <Leader>h <Plug>searchfoxlink
endif

noremap <unique> <script> <Plug>searchfoxlink <SID>searchfoxlink
noremap <SID>searchfoxlink :call <SID>Main()<CR>

