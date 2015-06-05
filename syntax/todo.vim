" First line of each note contains the title
syntax match todoProjectTitle /^.*\%1l.*$/ contains=@notesInline

" Short sentences ending in a colon are considered headings
syntax match todoHeading /^\s*\zs\u.\{1,50}\k:\ze\(\s\|$\)/ contains=@notesInline

" Atx style headings are also supported
syntax match todoAtxHeading /^#\+.*/ contains=todoAtxMarker,@notesInline
syntax match todoAtxMarker /^#\+/ contained

" Status markers
syntax match todoPendingMarker /\<TODO\>/ containedin=todoPendingItem
syntax match todoPendingItem /\<TODO\>.*$/ contains=@todoInline
syntax match todoProgressMarker /\<INPROGRESS\>/ containedin=todoProgressItem
syntax match todoProgressItem /\<INPROGRESS\>.*$/ contains=@todoInline
syntax match todoHoldMarker /\<HOLD\>/ containedin=todoHoldItem
syntax match todoHoldItem /\<HOLD\>.*$/ contains=@todoInline
syntax match todoDoneMarker /\<DONE\>/ containedin=todoDoneItem
syntax match todoDoneItem /\<DONE\>.*$/ contains=@todoInline

" List bullets and numbers
syntax match todoListBullet /^\*/
syntax match todoListNumber /^\s*\zs\d\+[[:punct:]]\?\ze\s/

" Highlight definitions
highlight def link todoProjectTitle ModeMsg
highlight def link todoHeading Title
highlight def link todoAtxMarker Comment
highlight def link todoAtxHeading Title

highlight def link todoPendingMarker WarningMsg
highlight def link todoProgressMarker Question
highlight def link todoHoldMarker Directory
highlight def link todoDoneMarker Comment

highlight def link todoPendingItem None
highlight def link todoProgressItem None
highlight def link todoHoldItem None
highlight def link todoDoneItem Comment

highlight def link todoListBullet Comment
highlight def link todoListNumber Comment
