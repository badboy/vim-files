if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet sec \\section{".st."name".et."}"
exec "Snippet sub \\subsection{".st."name".et."}"
exec "Snippet ssub \\subsubsection{".st."name".et."}"
exec "Snippet $$ \\[<CR>".st.et."<CR>\\]<CR>".st.et
exec "Snippet itd \\item[".st."desc".et."] ".st.et
