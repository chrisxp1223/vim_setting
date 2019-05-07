set nocompatible

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

call plug#begin('~/.vim/plugged')
Plug 'humiaozuzu/tabbar'
Plug 'itchyny/lightline.vim'
Plug 'wycats/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'brookhong/cscope.vim'
Plug 'c9s/colorselector.vim'
Plug 'kien/ctrlp.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'altercation/vim-colors-solarized'
Plug 'lokaltog/vim-powerline'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
"--Plug 'wraul/vim-easytags'
"--Plug 'xolox/vim-misc'
Plug 'raimondi/delimitmate'
Plug 'wesleyche/srcexpl'
Plug 'wesleyche/trinity'
Plug 'hari-rangarajan/cctree'
Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/c.vim'
Plug 'ervandew/supertab'
call plug#end()
filetype plugin indent on


"---General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set nofoldenable                                                  " disable folding"
set confirm                                                       " prompt when existing from an unsaved file"i
"set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set report=1                                                      " always report number of lines changed                "
set nowrap                                                        " dont wrap lines"
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling"
set showmatch                                                     " show matching bracket (briefly jump)"
set title                                                         " show file in titlebar"
set laststatus=2                                                  " use 2 lines for the s"
set matchtime=2                                                   " show matching bracket for 0.2 seconds"
set matchpairs+=<:>                                               " specially for html"
set tabstop=4              "4 space tab"
set shiftwidth=4           "The amount to block indent when using < and >"
set softtabstop=4          " Makes the spaces feel like real tabs"
set foldnestmax=3
set autoindent
set tabstop=4       " tab width"
set expandtab       " expand tab to space"
set cin                    " C indent"
set noautoindent           " always set autoindenting on"
set ic                     "Set case insensitive"

let g:Tb_MinSize = 1
let g:Tb_MaxSize = 3
let g:Tb_TabWrap = 1


"------------------------------------------------------------------------------
" C
"------------------------------------------------------------------------------
let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes'

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


command! Filename :call s:CopyFileName()
command! FileList :call s:OpenFileList()
command! Mak :call s:compile_this()
command! SearchAndList :call s:SearchAndList()
command! GrepC :call s:GrepC()
command! GrepJ :call s:GrepJ()
command! GrepXML :call s:GrepXML()

" ------------------------------------------------------------------------------
"  Color setting
colorscheme desert
syntax on
set background=dark
set mouse=a
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
"  "  Shortcut Implementation
"  "
"  ------------------------------------------------------------------------------
function! s:SearchAndList()
  let keyword = expand('<cword>')
  execute ':vimgrep '.keyword.' %'
  execute ':copen'
endfunction

function! s:GrepC()
  let keyword = expand('<cword>')
  execute ':vimgrep /'.keyword.'/j **/*.c'
  execute ':copen'
endfunction

" ------------------------------------------------------------------------------
"  File setting
" ------------------------------------------------------------------------------
" {{{
"set enc=big5       " ÀÉ®×½s½X³]¦¨ big5
set enc=utf8       " ÀÉ®×½s½X³]¦¨ big5
set fileencoding=utf8
"set encoding=cp950,unicode
" }}}

set smartcase         " Only do case sensitive match on Upper Case
set wildmenu          " Show possible command tab completions
set smartindent       " Backspace over expandtab
set guioptions-=T
set hls
set completeopt=menu

" misc
map  <S-S>       :w<CR>
"

"
" " Pasting blockwise and linewise selections is not possible in Insert and
" " Visual mode without the +virtualedit feature. They are pasted as if they
" " were characterwise instead.
" " Uses the paste.vim autoload script.
"
 exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
 exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
"
 imap <S-Insert>       <C-V>
 vmap <S-Insert>       <C-V>
"
" " CTRL-Z is Undo; not in cmdline though
 noremap <C-Z> u
 inoremap <C-Z> <C-O>u
"
"mswin.vim -->end


map  <F2>        :%s/\s\+$//              " Remove Whitespace
"map  <C-F3>      :wa<CR>:make<CR>
""map  <C-F4>      <ESC>:bd<CR>:bn<CR>
map  <F3>        :call CloseTab()<CR>
"map  <F3>        :call CloseTab2()<CR>
map  <F4>        <ESC>:FileList<CR>
map  <F5>        <ESC>:NERDTreeToggle<CR> " Toggles NERD Tree view (file viewer)"
map  <F6>        <ESC>:TlistToggle<CR>
""map  <F8>        <ESC>:QFSwitch<CR>
map  <S-F8>      <ESC>:colder<CR>
map  <C-F8>      <ESC>:cnewer<CR>
map  <F12>       :!ctags -R --languages=asm,c,c++,java,make --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.git --exclude=.svn --exclude=out --exclude=pub --exclude=prebuilts<CR>

" Tools
map  <F7>        <ESC>:SrcExplToggle<CR>  " Toggles the Source Explorer

nmap <F8>        :TrinityToggleAll<CR> 

" tags
nmap tj          :exec "tjump ".expand("<cword>")<CR>
nmap tk          :exec "ts ".expand("<cword>")<CR>
nmap tn          :exec "tnext"<CR>
nmap tp          :exec "tprevious"<CR>
nmap ta          :tags<CR>

" searc
map sa :exec "/\\(".getreg('/')."\\)\\\\|".expand("<cword>")<CR>


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
" ------------------------------------------------------------------------------
"  Editor setting
" ------------------------------------------------------------------------------
" {{{


"set foldmethod=indent      " Marker

filetype on
filetype indent on         "new in vim 6.0+; file type specific indenting
filetype plugin on         "new in vim 6.0+; file type specific indenting

set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
"set guifont=Monaco\ 12

" Donot jump to TabBar windows. Always jump to below window of TabBar
"autocmd! BufEnter * nested call <SID>Test()
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
"  " Nerd Tree
"  "
"  ------------------------------------------------------------------------------
"
autocmd VimEnter * NERDTree
wincmd w 
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc', '\.pyo', '\.swp', '\~'] " ignore *.py[co], *.swp and *~O
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
"nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"
"
" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2
"
" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
"let g:airline_powerline_fonts = 1
"
" Show PASTE if in paste mode
" let g:airline_detect_paste=1
"
" Show airline for tabs too
" let g:airline#extensions#tabline#enabled = 1

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END


" ----- xolox/vim-easytags settings -----
" Where to look for tags files
" set tags=./tags;,~/.vimtags
" Sensible defaults
" let g:easytags_events = ['BufReadPost', 'BufWritePost']
" let g:easytags_async = 1
" let g:easytags_dynamic_files = 2
" let g:easytags_resolve_links = 1
" let g:easytags_suppress_ctags_warning = 1
"
" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"
" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ------------------------------------------------------------------------------
"  MarksBrowser
" ------------------------------------------------------------------------------
" {{{
" To open the browser, use the :MarksBrowser command
let marksCloseWhenSelected = 0
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
"  "  File setting
"  "
"  ------------------------------------------------------------------------------
"  " {{{
"set enc=big5       " ÀÉ®×½s½X³]¦¨ big5
set enc=utf8       " ÀÉ®×½s½X³]¦¨ big5
set fileencoding=utf8
"  "set encoding=cp950,unicode
"  " }}}
"  "
"  }}}
let g:pep8_map='<leader>8'



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
endfunctio


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


