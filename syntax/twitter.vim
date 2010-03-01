" Beautify the Twitter window with syntax highlighting.
"if has("syntax") && exists("g:syntax_on") && !has("syntax_items")

" Twitter user name: from start of line to first colon.
syntax match twitterUser /^.\{-1,}:/

" Use the bars to recognize the time but hide the bars.
syntax match twitterTime /|[^|]\+|$/ contains=twitterTimeBar
syntax match twitterTimeBar /|/ contained

" Highlight links in tweets.
syntax match twitterLink "\<http://\S\+"
syntax match twitterLink "\<https://\S\+"
syntax match twitterLink "\<ftp://\S\+"

" An @-reply must be preceded by whitespace and ends at a non-word
" character.
syntax match twitterReply "\S\@<!@\w\+"

" A #-hashtag must be preceded by whitespace and ends at a non-word
" character.
syntax match twitterLink "\S\@<!#\w\+"

"if a:wintype != userinfo"
"    " Use the extra star at the end to recognize the title but hide the
"    " star.
   syntax match twitterTitle /^.\+\*$/ contains=twitterTitleStar
    syntax match twitterTitleStar /\*$/ contained
"endif

highlight default link twitterUser Identifier
highlight default link twitterTime String
highlight default link twitterTimeBar Ignore
highlight default link twitterTitle Title
highlight default link twitterTitleStar Ignore
highlight default link twitterLink Underlined
highlight default link twitterReply Label
