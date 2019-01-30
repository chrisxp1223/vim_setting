" Vim syntax file
" Language:	inf template
" Maintainer:	doro wu<doro_wu@asus.com.tw>
" Last Change:	2007 Jan 26

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

if version < 600
  so <sfile>:p:h/django.vim
  so <sfile>:p:h/html.vim
else
  runtime! syntax/django.vim
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

syn match infSection		"\[.*\]"
syn match infComment		"^#.*"

if version >= 508 || !exists("did_asm_syntax_inits")
  if version < 508
    let did_asm_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink infSection Label
  HiLink infComment Comment

  delcommand HiLink
endif

let b:current_syntax = "efi inf"
" vim: ts=8
