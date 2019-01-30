" Title:        QFSwitch 
" Author:       Doro Wu
" Goal:         Open QuickFix window if it's opened. Close Quickfix window if
"               it's closed
" Usage:        This file should reside in the plugin directory and be
"               automatically sourced.
" License:      Public domain, no restrictions whatsoever
" Contribute:   Please report any bugs or suggestions to
"               fcwu.tw@gmail.com
"
" Version:      See g:QFSwitchVersion for version number.
" History:     
" Keymappings:
"
"    <Leader>qs  - Switch QuickFix on or off
"    <Leader>ql  - Go to next QuickFix buffer
"    <Leader>qh  - Go to previous QuickFix buffer
"
" Commands:
"
"    ":QFSwitch"
"       Switch QuickFix window
"
" Options:
"

"
" Initialization {{{
if exists("g:QFSVersion") || &cp || !has("quickfix")
    finish
endif
let g:QFSVersion = "0.1"
if v:version < 700
  echo "Sorry, QuickFixSwitch ".g:QFSVersion."\nONLY runs with Vim 7.0 and greater."
  finish
endif
" }}}

" Internals {{{
" Variables {{{
"
" }}}
" helper functions {{{
"
" }}}
" }}}

" QFSwitch {{{
function! <sid>QFSwitch()
    redir => ls_output
    execute ':silent! ls'
    redir END

    let exists = match(ls_output, "[Quickfix List")

    if exists == -1 
        execute ':copen'

        let qf_count = 1
        try
            while 1
                silent colder
            endwhile
        catch /^Vim(\a\+):E380:/
        endtry

        try
            while 1
                silent cnewer
                let qf_count += 1
            endwhile
        catch /^Vim(\a\+):E381:/
        endtry

        echo "QuickFix count: ".qf_count

        setlocal nomodifiable
    else
        execute ':cclose'
    endif
endfunction
" }}}


" Global {{{
" Variable setting {{{
" }}}
" Commands {{{
command! -nargs=0 QFSwitch :call s:QFSwitch()
" }}}
" Keymaps {{{
if !hasmapto("<plug>QFSwitch")
    map <silent> <Leader>qs <plug>QFSwitch
endif
map <silent> <Leader>qh    :cnewer<CR>
map <silent> <Leader>ql    :colder<CR>

nmap <silent> <unique> <script> <plug>QFSwitch      :call <sid>QFSwitch()<CR>
" }}}
" }}}

