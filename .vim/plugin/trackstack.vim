" Title:        TrackStack
" Author:       Doro Wu
" Goal:         Show tags buffers, cooperated with Source Explorer
" Usage:        This file should reside in the plugin directory and be
"               automatically sourced.
" License:      Public domain, no restrictions whatsoever
" Contribute:   Please report any bugs or suggestions to
"               fcwu.tw@gmail.com
"
" Version:      See g:TSVersion for version number.
" History:     
" Keymappings:
" Commands:
" Options:
"

"
" Initialization {{{
if exists("g:TSVersion") 
    finish
endif
let g:TSVersion = "0.1"
if v:version < 700
  echo "Sorry, TrackStack ".g:TSVersion."\nONLY runs with Vim 7.0 and greater."
  finish
endif

autocmd! CursorHold * nested call <sid>TSRefresh()
"autocmd! WinEnter * nested call <sid>TSRefresh()
" }}}
  
" Internals {{{
" Variables {{{
let s:TSTitle      =   "__TrackStack__"
let s:SETitle      =   "Source_Explorer"
let s:TSWinAnchor  =   ""
let s:TSWinOpen    =   0
let s:TSFocusWin   =   -1
"
" }}}
" helper functions {{{
" TSWindowGo {{{
function! s:TSWindowGo(winname)
    " Move cursor to top-left window.
    silent! wincmd t

    let winIterPrev = 0
    let winIter = 1
    " work around all windows and stop when matching
    while winIterPrev < winIter
        if a:winname == bufname("%")
            break
        endif
        " go to next window
        silent! wincmd w
        let winIterPrev = winIter
        let winIter = winnr()
    endwhile 
endfunction
" }}}
" TSWindowAnchor {{{
function! s:TSWindowAnchor()
    let s:TSWinAnchor = bufname("%")
endfunction
" }}}
" TSWindowBack {{{
function! s:TSWindowBack()
    " Move cursor to top-left window.
    silent! wincmd t

    let winIterPrev = 0
    let winIter = 1
    " work around all windows and stop when matching
    while winIterPrev < winIter
        if s:TSWinAnchor == bufname("%")
            break
        endif
        " go to next window
        silent! wincmd w
        let winIterPrev = winIter
        let winIter = winnr()
    endwhile 
endfunction
" }}}
" TSWindowFind {{{
function! s:TSWindowExist(winname)
    redir => ls_output
    silent! buffers
    redir END
    let l:exists = match(ls_output, a:winname)
    if l:exists >= 0
        return 1
    endif
    return 0
endfunction
" }}}
" }}}


" Global {{{
"
" Variable setting {{{
" }}}
"
" Functions {{{
"
" TSWindowToggle {{{
function! <sid>TSWindowToggle()
    call s:TSWindowAnchor()

    if s:TSWinOpen == 0

        " Open source explorer first
        let exists = s:TSWindowExist(s:SETitle)
        if exists == 0
            execute ':silent! SrcExplToggle'
        endif

        " Move cursor to SrcExplorer.
        call s:TSWindowGo(s:SETitle)

        " Vertical new a file
        exec "silent! vnew " . s:TSTitle
        " Rotate windows downwards/rightwards. Move to that new file
        silent! wincmd r
        " Show its name on the buffer list
        setlocal buflisted
        " No exact file
        setlocal buftype=nofile
        " Make it no modifiable
        setlocal nomodifiable
        " Make it no number line
        setlocal nonumber
        setlocal nowrap

        let s:TSWinOpen = 1
    else
        let exists = s:TSWindowExist(s:SETitle)
        if exists > 0
            execute ':silent! SrcExplToggle'
        endif

        call s:TSWindowGo(s:TSTitle)
        silent! wincmd c
        let l:bufnum = bufnr(s:TSTitle)
        if l:bufnum != -1
            exe "bdelete! " . s:TSTitle
        endif

        let s:TSWinOpen = 0
    endif

    call s:TSWindowBack()
    call <sid>TSSetFocusWin()
    call <sid>TSRefresh()

endfunction
" }}}
" TSRefresh {{{
function! <sid>TSRefresh()

    "
    " Check if moving to __TrackStack__ window
    " If not found, donot update anything
    "
    if s:TSWinOpen == 0
        return
    endif
    if s:TSFocusWin != winnr()
        "echo "Unmatched " . s:TSFocusWin . ":" . winnr()
        return 
    endif


    " 
    " Start updating
    " 

    " Retrieve output of tags command
    " Must retieve before jump to TSWindow
    redir => tags_output
    silent! tags
    redir END

    call s:TSWindowAnchor()
    call s:TSWindowGo(s:TSTitle)
    setlocal modifiable


    " Delete all context in TSWindow
    execute "normal ggVGx"
    " Write tags in
    execute "normal a" . strtrans(tags_output)
    " Delete empty line
    " execute ":silent! g/^\s*$/d"
    execute ":silent! %s/\\^@/\r/g"
    execute ":silent! g/^\s*$/d"
    execute "normal gg0"

    setlocal nomodifiable
    call s:TSWindowBack()

endfunction
" }}}
" TSSetFocusWin {{{
function! <sid>TSSetFocusWin()
    let s:TSFocusWin = winnr()
endfunction
" }}}
" }}}
" Commands {{{
command! -nargs=0 TSWindowToggle :call <sid>TSWindowToggle()
command! -nargs=0 TSRefresh      :call <sid>TSRefresh()
command! -nargs=0 TSSetFocusWin  :call <sid>TSSetFocusWin()
" }}}
" Keymaps {{{
if !hasmapto("<plug>TSWindowOpen")
    map <silent> <Leader>t1 <plug>TSWindowToggle
endif

nmap <silent> <unique> <script> <plug>TSWindowToggle      :call <sid>TSWindowToggle()<CR>
" }}}
" }}}

