" Help {{{
"<html><body>You are being <a href="https://github.com/c9s/helper.vim/raw/master/plugin/helper.vim">redirected</a>.</body></html>
" Author:  Cornelius <cornelius.howl@gmail.com>
" Version: 0.2
" ScriptType: plugin

let g:Help = {}

fun! g:Help.reg(brief,fulltext,show_brief)
  let b:help_brief = a:brief . ' | Press ? For Help.'
  let b:help_brief_height = 0
  let b:help_show_brief_on = a:show_brief

  let b:help_fulltext = "Press ? To Hide Help\n" . a:fulltext
  let b:help_fulltext_height = 0

  nmap <buffer><script>  ?  :cal <SID>toggle_fulltext()<CR>

  if b:help_show_brief_on
    cal g:Help.show_brief()
  endif
  cal g:Help.init_syntax()
endf

fun! g:Help.redraw()
  cal g:Help.show_brief()
endf

fun! s:toggle_fulltext()
  setlocal modifiable
  if exists('b:help_fulltext_on')
    cal g:Help.hide_fulltext()
  else
    cal g:Help.show_fulltext()
  endif
  setlocal nomodifiable
endf

fun! g:Help.show_brief()
  let lines = split(b:help_brief,"\n")
  let b:help_brief_height = len(lines)
  cal map(lines,"'# ' . v:val")
  cal append( 0 , lines  )
endf

fun! g:Help.init_syntax()

endf

fun! g:Help.hide_brief()
  exec 'silent 1,'.b:help_brief_height.'delete _'
endf

fun! g:Help.show_fulltext()
  let b:help_fulltext_on = 1

  if b:help_show_brief_on
    cal g:Help.hide_brief()
  endif

  let lines = split(b:help_fulltext,"\n")
  cal map(lines,"'# ' . v:val")

  let b:help_fulltext_height = len(lines)
  cal append( 0 , lines  )
endf

fun! g:Help.hide_fulltext()
  unlet b:help_fulltext_on
  exec 'silent 1,'.b:help_fulltext_height.'delete _'
  if b:help_show_brief_on
    cal g:Help.show_brief()
  endif
endf
" }}}

