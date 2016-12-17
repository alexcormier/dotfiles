" Vim syntax file
" Language:	git commit file
" Maintainer:	Alexandre Cormier <alexandre@cormier.io>
" Filenames:	*.git/COMMIT_EDITMSG
" Last Change:	2016 December 17

syn match   gitcommitParagraph      "\%>2l.\{0,72\}" nextgroup=gitcommitOverflow contains=@Spell
hi def link gitcommitParagraph      Keyword
hi def link gitcommitOverflow       Error
