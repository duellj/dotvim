" The commands in this are executed when the GUI is started.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1


" set window size
set columns=150
set lines=60

" set colorscheme
set background=dark

" Make command line two lines high
set ch=2

" Turn off beep
set visualbell

" Hide the mouse when typing text
set mousehide

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Hide toolbar in GUI
set guioptions-=T

" Only enable IndentGuides in GUI
let g:indent_guides_enable_on_vim_startup = 1

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

endif
