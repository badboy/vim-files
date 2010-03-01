if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet img ![".st."altText".et."](".st."SRC".et.")".st.et
exec "Snippet link [".st."desc".et."](".st."HREF".et.")".st.et
exec "Snippet href [".st."desc".et."][".st."ID".et."]".st.et
exec "Snippet hln {% highlight ".st."ruby".et." linenos %}<CR>".st.et."<CR>{% endhighlight %}<CR>".st.et
exec "Snippet hl {% highlight ".st."ruby".et." %}<CR>".st.et."<CR>{% endhighlight %}<CR>".st.et
exec "Snippet br <br/>".st.et

