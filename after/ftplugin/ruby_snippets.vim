if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet #! #!/usr/bin/env ruby<CR> encoding: utf-8<CR>".st.et

exec "Snippet do do<CR>".st.et."<CR>end<CR>"
exec "Snippet class class ".st."ClassName".et."<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet begin begin<CR>".st.et."<CR>rescue ".st."Exception".et." => ".st."e".et."<CR>".st.et."<CR>end<CR>"
exec "Snippet =begin =begin<CR> * ".st.et."<CR>=end<CR>"
exec "Snippet each_with_index0 each_with_index do |".st."element".et.", ".st."index".et."|<CR>".st."element".et.".".st.et."<CR>end<CR>"
exec "Snippet collect collect { |".st."element".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet forin for ".st."element".et." in ".st."collection".et."<CR>".st."element".et.".".st.et."<CR>end<CR>"
exec "Snippet doo do |".st."object".et."|<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet : :".st."key".et." => \"".st."value".et."\"".st.et."<CR>"
exec "Snippet def def ".st."methodName".et."<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet case case ".st."object".et."<CR>when ".st."condition".et."<CR>".st.et."<CR>end<CR>".st.et
exec "Snippet collecto collect do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end<CR>".st.et
exec "Snippet each each { |".st."element".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet each_with_index each_with_index { |".st."element".et.", ".st."idx".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet if if ".st."condition".et."<CR>".st.et."<CR>end<CR>"
exec "Snippet eacho each do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end<CR>"
exec "Snippet unless unless ".st."condition".et."<CR>".st.et."<CR>end<CR>"
exec "Snippet ife if ".st."condition".et."<CR>".st.et."<CR>else<CR>".st.et."<CR>end<CR>"
exec "Snippet when when ".st."condition".et."<CR>"
exec "Snippet selecto select do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end<CR>"
exec "Snippet injecto inject(".st."object".et.") do |".st."injection".et.", ".st."element".et."| <CR>".st.et."<CR>end<CR>"
exec "Snippet reject { |".st."element".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet rejecto reject do |".st."element".et."| <CR>".st."element".et.".".st.et."<CR>end<CR>"
exec "Snippet inject inject(".st."object".et.") { |".st."injection".et.", ".st."element".et."| ".st.et." }<CR>"
exec "Snippet select select { |".st."element".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet classi class ".st."ClassName".et."<CR>def initialize(".st."args".et.")<CR>".st.et."<CR><CR>end<CR>".st.et."<CR>end<CR>"
exec "Snippet map map { |".st."element".et."| ".st."element".et.".".st.et." }<CR>"
exec "Snippet mapo map do |".st."element".et."|<CR>".st."element".et.".".st.et."<CR>end<CR>"
