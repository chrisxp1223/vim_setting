filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ------------------------------------------------------------------------------
"  Windows setting
" ------------------------------------------------------------------------------
" set nocompatible
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin
au BufNewFile,BufRead *.inf set filetype=inf
au BufNewFile,BufRead *.dsc set filetype=inf

" ------------------------------------------------------------------------------
"  Test
" ------------------------------------------------------------------------------
autocmd BufNew,BufRead *.asl setf asl
autocmd BufNew,BufRead *.asx setf asl
autocmd BufNew,BufRead *.inc setf asm
autocmd BufNew,BufRead *.mac setf asm

set smartcase         " Only do case sensitive match on Upper Case
set wildmenu          " Show possible command tab completions
set smartindent       " Backspace over expandtab
set guioptions-=T
set hls
set completeopt=menu

command! Filename :call s:CopyFileName()
command! FileList :call s:OpenFileList()
command! Mak :call s:compile_this()
command! SearchAndList :call s:SearchAndList()
command! GrepC :call s:GrepC()
command! GrepJ :call s:GrepJ()
command! GrepXML :call s:GrepXML()

filetype plugin on

" ------------------------------------------------------------------------------
"  Shortcut
" ------------------------------------------------------------------------------
" {{{
"     commands:				      modes: Normal  Visual+Select  Operator-pending
" :map   :noremap   :unmap   :mapclear	 yes	      yes          yes
" :nmap  :nnoremap  :nunmap  :nmapclear	 yes	       -            -
" :vmap  :vnoremap  :vunmap  :vmapclear	  -	          yes           -
" :omap  :onoremap  :ounmap  :omapclear	  -	           -           yes
"     commands:				      modes: Insert  Command-line	Lang-Arg
" :map!  :noremap!  :unmap!  :mapclear!	  yes	      yes	        -
" :imap  :inoremap  :iunmap  :imapclear	  yes		   -	        -
" :cmap  :cnoremap  :cunmap  :cmapclear	   -	      yes	        -
" :lmap  :lnoremap  :lunmap  :lmapclear	  yes*        yes*	       yes*
map  <F2>        :%s/\s\+$//              " Remove Whitespace
"map  <C-F3>      :wa<CR>:make<CR>
"map  <C-F4>      <ESC>:bd<CR>:bn<CR>
"map  <F3>        :call CloseTab()<CR>
map  <F3>        :call CloseTab2()<CR>
map  <F4>        <ESC>:FileList<CR>

" Tools
map  <F5>        <ESC>:NERDTreeToggle<CR> " Toggles NERD Tree view (file viewer)
map  <F6>        <ESC>:TlistToggle<CR>
map  <F7>        <ESC>:SrcExplToggle<CR>  " Toggles the Source Explorer
map  <F8>        <ESC>:QFSwitch<CR>
map  <S-F8>      <ESC>:colder<CR>
map  <C-F8>      <ESC>:cnewer<CR>

"<F9> mark: in plugin files
map  <F9>        <Plug>Vm_toggle_sign
map  <C-F9>      <Plug>Vm_goto_next_sign
map  <S-F9>      <Plug>Vm_goto_prev_sign
map  <C-F11>     :!cscope -Rbkq<cr>
"map  <F12>       :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f "%:p:h\\tags" "%:p:h"<CR>
"map  <C-F12>     :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map  <F12>       :!ctags -R --languages=asm,c,c++,java,make --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.git --exclude=.svn --exclude=out --exclude=pub --exclude=prebuilts<CR>

" misc
map  <S-S>       :w<CR>

"mswin.vim -->start
" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X is Cut
vnoremap <C-X> x

" CTRL-C is Copy
vnoremap <C-C> y

" SHIFT-V is Paste
map <S-V>		p

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature. They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

"mswin.vim -->end

set mp=gcc\ -Wall\ %\ -o\ %:r.exe
map  <C-n>       <ESC>:cnext<CR>
map  <C-p>       <ESC>:cprev<CR>

" Finder
map  f/          :Grep
map  ff          :FuzzyFinderFile<CR>
map  fcd         :FuzzyFinderDir<CR>
map  fba         :FuzzyFinderAddBookmark<CR>
map  fbl         :FuzzyFinderBookmark<CR>
map  fu          :FuzzyFinderBuffer<CR
map  fmf         :FuzzyFinderMruFile<CR>
nmap <silent> <C-\>      :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
map  fh          :call FileHeaderSource()<CR>
nmap <Leader>*       :SearchAndList<CR>

" tags
nmap tj          :exec "tjump ".expand("<cword>")<CR>
nmap tk          :exec "ts ".expand("<cword>")<CR>
nmap tn          :exec "tnext"<CR>
nmap tp          :exec "tprevious"<CR>
nmap ta          :tags<CR>

" window
map <c-j>        <c-w>j
map <c-k>        <c-w>k
map <c-l>        <c-w>l
map <c-h>        <c-w>h

" searc
map sa :exec "/\\(".getreg('/')."\\)\\\\|".expand("<cword>")<CR>

nmap fc :GrepC<CR>
nmap fj :GrepJ<CR>
nmap fx :GrepXML<CR>

" ------------------------------------------------------------------------------
"  Shortcut Implementation
" ------------------------------------------------------------------------------
function! s:SearchAndList()
    let keyword = expand('<cword>')
    execute ':vimgrep '.keyword.' %'
    execute ':copen'
endfunction

function! s:GrepC()
    let keyword = expand('<cword>')
    execute ':vimgrep /'.keyword.'/j **/*.cpp'
    execute ':copen'
endfunction

function! s:GrepJ()
    let keyword = expand('<cword>')
    execute ':vimgrep /'.keyword.'/j **/*.java'
    execute ':copen'
endfunction

function! s:GrepXML()
    let keyword = expand('<cword>')
    execute ':vimgrep /'.keyword.'/j **/*.xml'
    execute ':copen'
endfunction

function! FileHeaderSource()
  let fextname=expand("%:e")
  let fname=expand("%:r")
  if fextname=="h"
    if filereadable(fname.".cpp")
      exec ':e '.fname.".cpp"
      return
    endif
    if filereadable(fname.".c")
      exec ':e '.fname.".c"
      return
    endif
  else
    if filereadable(fname.".h")
      exec ':e '.fname.".h"
      return
    endif
  endif
  echo "file not found"
endfunction

function! s:OpenFileList()
    if !filereadable('filelist.txt')
        silent exec "!find . -type f  | grep -v '/.git/' > filelist.txt"
    endif
    execute 'e filelist.txt'
    setlocal buftype=nofile readonly nomodifiable
    execute 'setlocal bufhidden='
    "silent put=readfile('filelist.txt')
    "keepjumps 0d
    "setlocal nomodifiable
    nnoremap <buffer> <Enter> :set nocursorline<Enter>gf<Enter>
    set cursorline

    "let b:is_msg_buffer = 1
endfunction

function! s:CopyFileName()
    call setreg("+", expand("%:p"))
endfunction

function! s:compile_this()
    let _prg = &makeprg
    setlocal makeprg=g++\ -Wall\ -o\ %:r.exe\ %
    normal make
    normal cw
endfunction
" }}}

" ------------------------------------------------------------------------------
"  Color setting
" ------------------------------------------------------------------------------
" {{{
colorscheme torte
syntax on                  "turns on syntax highlighting
" }}}

" ------------------------------------------------------------------------------
"  General setting
" ------------------------------------------------------------------------------
" {{{
set nobackup
"set backupdir=d:\tmp
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set laststatus=2   "Display a status-bar.
set viminfo='20,\"50    " read/write a .viminfo file, don't store more " than 50 lines of registers
set formatoptions=mtcql
au! BufWritePost .vimrc source %  " reconfigure when vimrc has been writen
" User Defined Status Line.
" @see http://www.vim.org/scripts/script.php?script_id=8 for VimBuddy.
"set statusline=%f\ %1*%m%*\ %1*%r%*\ %1*%h%*\ %1*%w%*%=\ [%{VimBuddy()}]\ [%Y:%{toupper(&ff)}:%{toupper(&fenc!=''?&fenc:&enc)}]\ [ASCII:%b]\ [%l%2*/%L(%p%%)%*,%v]
hi User1 guibg=red guifg=yellow
hi User2 guibg=#C2BFA5 guifg=#666666
"set fdm=syntax
"set fdc=4
" }}}

func! CloseTab()
  let s:buf_nr = bufnr("%")
  echo s:buf_nr
  exec ":Tbbp "
  exec ":bd ".s:buf_nr
endfunction

func! CloseTab2()
  let s:buf_nr = bufnr("%")
  echo s:buf_nr
  exec ":Tbbp "
  exec ":bw ".s:buf_nr
endfunction

" show trailing white spaces
highlight WhitespaceEOL ctermbg=red guibg=red
"match WhitespaceEOL /\s\+$/

"function RemoveWhitespace()
"    if &ft != "diff"
"        let b:curcol = col(".")
"        let b:curline = line(".")
"        silent! %s/\s\+$//
"        silent! %s/\(\s*\n\)\+\%$//
"        call cursor(b:curline, b:curcol)
"    endif
"endfunction
"autocmd BufWritePre * call RemoveWhitespace()



" ------------------------------------------------------------------------------
"  File setting
" ------------------------------------------------------------------------------
" {{{
"set enc=big5       " ÀÉ®×½s½X³]¦¨ big5
set enc=utf8       " ÀÉ®×½s½X³]¦¨ big5
set fileencoding=utf8
"set encoding=cp950,unicode
" }}}

" ------------------------------------------------------------------------------
"  Editor setting
" ------------------------------------------------------------------------------
" {{{
set number
set incsearch

set smarttab               "Uses shiftwidth instead of tabstop at start of lines
"set expandtab              "Replaces a <TAB> with spaces--more portable
set tabstop=4              "4 space tab
set shiftwidth=4           "The amount to block indent when using < and >
set softtabstop=4          " Makes the spaces feel like real tabs
set backspace=indent,eol,start
"set bs=2                   "Default backspace like normal

"set foldmethod=indent      " Marker
set foldnestmax=3

set cin                    " C indent
set noautoindent           " always set autoindenting on
filetype on
filetype indent on         "new in vim 6.0+; file type specific indenting
filetype plugin on         "new in vim 6.0+; file type specific indenting

set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
"set guifont=Monaco\ 12

set showmatch              "Show matching parenthese.
set ic                     "Set case insensitive"
" Donot jump to TabBar windows. Always jump to below window of TabBar
autocmd! BufEnter * nested call <SID>Test()
func! s:Test()
    if bufname("%") == "-TabBar-"
        wincmd j
    endif
endfunction

" let g:Tb_VSplit = 1
let g:Tb_MinSize = 1
let g:Tb_MaxSize = 3
let g:Tb_TabWrap = 1
" }}}

" ------------------------------------------------------------------------------
"  Highlight
" ------------------------------------------------------------------------------
" {{{
hi Comment      term=bold ctermfg=darkcyan
hi Constant     term=underline ctermfg=Red
hi Special      term=bold ctermfg=Magenta
hi Identifier   term=underline ctermfg=cyan
hi Statement    term=bold ctermfg=Brown
hi PreProc      term=bold ctermfg=DarkYellow
hi Type         term=bold ctermfg=DarkGreen
hi Ignore       ctermfg=white
hi Error        term=reverse ctermbg=Red ctermfg=White
hi Todo         term=standout ctermbg=Yellow ctermfg=Red
hi Search       term=standout ctermbg=Yellow ctermfg=Black
hi ErrorMsg     term=reverse ctermbg=Red ctermfg=White
hi StatusLine   ctermfg=darkblue  ctermbg=gray
hi StatusLineNC ctermfg=brown   ctermbg=darkblue
" }}}


" ------------------------------------------------------------------------------
" TagList
" ------------------------------------------------------------------------------
" {{{
" TagListTagName  - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue
" TagListTitle    - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
" TagListComment  - Used for comments
highlight MyTagListComment guifg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue

"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 0 " split to the right side of the screen
let Tlist_Sort_Type = "name" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 0 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]
" }}}

" ------------------------------------------------------------------------------
"  MarksBrowser
" ------------------------------------------------------------------------------
" {{{
" To open the browser, use the :MarksBrowser command
let marksCloseWhenSelected = 0
" }}}

" ------------------------------------------------------------------------------
"  VirtualMark
" ------------------------------------------------------------------------------
" {{{
"  map <unique> <F9> <Plug>Vm_toggle_sign
"  map <unique> <c-F9> <Plug>Vm_goto_next_sign
"  map <unique> <s-F9> <Plug>Vm_goto_prev_sign
" }}}

" ------------------------------------------------------------------------------
" SrcExplore
" ------------------------------------------------------------------------------
" {{{
" // Set the height of Source Explorer window                                  "
let g:SrcExpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer                             "
let g:SrcExpl_refreshTime = 100
" // Set "Enter" key to jump into the exact definition context                 "
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context                      "
let g:SrcExpl_goBackKey = "<SPACE>"
" // Enable or disable local definition searching, and note that this is not   "
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. "
" // It only searches for a match with the keyword according to command 'gd'   "
"let g:SrcExpl_searchLocalDef = 1
"                                                                              "
" // Let the Source Explorer update the tags file when opening                 "
let g:SrcExpl_isUpdateTags = 0
"                                                                              "
" // Use program 'ctags' with argument '-R *' to create or update a tags file  "
let g:SrcExpl_updateTagsCmd = "ctags -R *"
" }}}

" ------------------------------------------------------------------------------
" EasyGrep
" ------------------------------------------------------------------------------
" {{{
"    <Leader>vv  - Grep for the word under the cursor, match all occurences,
"                  like |gstar|
"    <Leader>vV  - Grep for the word under the cursor, match whole word, like
"                  |star|
"    <Leader>va  - Like vv, but add to existing list
"    <Leader>vA  - Like vV, but add to existing list
"
"    <Leader>vr  - Perform a global search search on the word under the cursor
"    nmap <silent> <leader>vya    :call <sid>ActivateAll()<cr>
"    nmap <silent> <leader>vyb    :call <sid>ActivateBuffers()<cr>
"    nmap <silent> <leader>vyt    :call <sid>ActivateTracked()<cr>
"    nmap <silent> <leader>vyu    :call <sid>ActivateUser()<cr>
"
"    nmap <silent> <leader>vyc    :call <sid>ToggleCommand()<cr>
"    nmap <silent> <leader>vyr    :call <sid>ToggleRecursion()<cr>
"    nmap <silent> <leader>vyd    :call <sid>ToggleIgnoreCase()<cr>
"    nmap <silent> <leader>vyi    :call <sid>ToggleHidden()<cr>
"    nmap <silent> <leader>vyw    :call <sid>ToggleWindow()<cr>
"    nmap <silent> <leader>vyo    :call <sid>ToggleOpenWindow()<cr>
"    nmap <silent> <leader>vyg    :call <sid>ToggleEveryMatch()<cr>
"    nmap <silent> <leader>vyp    :call <sid>ToggleJumpToMatch()<cr>
"    nmap <silent> <leader>vy!    :call <sid>ToggleWholeWord()<cr> "    nmap <silent> <leader>vye    :call <sid>EchoFilesSearched()<cr>
"    nmap <silent> <leader>vys    :call <sid>Sort()<cr>
"    nmap <silent> <leader>vy/    :call <sid>ToggleOptionsDisplay()<cr>
"    nmap <silent> <leader>vy?    :call <sid>EchoOptionsSet()<cr>

"    "g:EasyGrepCommand" - Specifies the grep command to use
"    0 - vimgrep
"    1 - grep (follows grepprg)
let g:EasyGrepCommand = 0
" let g:EasyGrepFileAssociations = "G:\\software\\Vim\\vim72\\plugin\\EasyGrepFileAssociations"
let g:EasyGrepRecursive = 1
let g:EasyGrepHidden = 0
let g:EasyGrepExtraWarnings=0
let g:EasyGrepIgnoreCase= 1

" ------------------------------------------------------------------------------
" backup
" ------------------------------------------------------------------------------
"  g:backup_directory	name of backup directory local to edited file
"			used for non VMS only. Since non VMS operating-
"			systems don't know about version we would get
"			ugly directory listings. So all backups are
"			moved into a hidden directory.
"
"  g:backup_purge	count of backups to hold - purge older once.
let g:backup_purge=10

" ------------------------------------------------------------------------------
" Pep8
" ------------------------------------------------------------------------------
"The final plugin that really helps validate your code is the pep8 plugin, it'll make sure your code is consistent across all projects. Add a key mapping to your ~/.vimrc and then you'll be able to jump to each of the pep8 violations in the quickfix window:
"
let g:pep8_map='<leader>8'

" ------------------------------------------------------------------------------
" git
" ------------------------------------------------------------------------------
"nnoremap <Leader>gd :GitDiff<Enter>
"nnoremap <Leader>gD :GitDiff --cached<Enter>
"nnoremap <Leader>gs :GitStatus<Enter>
"nnoremap <Leader>gl :GitLog<Enter>
"nnoremap <Leader>ga :GitAdd<Enter>
"nnoremap <Leader>gA :GitAdd <cfile><Enter>
"nnoremap <Leader>gc :GitCommit<Enter>
"nnoremap <Leader>gp :GitPullRebase<Enter>

" ------------------------------------------------------------------------------
"
" ------------------------------------------------------------------------------
if filereadable('.localvimrc')
    source .localvimrc
endif

au BufNewFile,BufRead *.py call s:python_config()
function! s:python_config()
    set omnifunc=pythoncomplete#Complete
    let g:SuperTabDefaultCompletionType = "context"
    set completeopt=menuone,longest,preview
    set foldmethod=indent
    set foldlevel=99
endfunction

:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
":nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
