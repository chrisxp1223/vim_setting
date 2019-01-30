" Vim filetype plugin file
" Language:	asm
" Maintainer:	Doro Wu<doro_wu@asus.com.tw>
" Last Change:	2009 Jan 16

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

set tabstop=8              "4 space tab
set shiftwidth=8           "The amount to block indent when using < and >
set softtabstop=8          "Causes backspace to delete 4 spaces = converted <TAB>

