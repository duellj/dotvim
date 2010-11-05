"
" MAIN CUSTOMIZATION FILE
"

" Active pathogen bundle manager
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable loading filetype and indentation plugins
filetype plugin on
filetype indent on

" Turn syntax highlighting on
syntax on

"
" GLOBAL SETTINGS
"
set fo=crq
set textwidth=80


" Set autoindent for all files
set autoindent

" Write contents of the file, if it has been modified, on buffer exit
set autowrite

" Allow backspacing over everything
set backspace=indent,eol,start

" Insert mode completion options
set completeopt=menu,longest,preview

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Remember up to 100 'colon' commmands and search patterns
set history=100

" Enable incremental search
set incsearch

" Enable case insensitive search
set ignorecase
let b:match_ignorecase=0

" Ignore ignorecase when search pattern contains an upper case character
set smartcase

" Always show status line, even for one window
set laststatus=2

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Don't highlight results of a search
set nohlsearch

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Use F10 to toggle 'paste' mode
set pastetoggle=<F10>

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 2 spaces for (auto)indent
set shiftwidth=2

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Don't request terminal version string (for xterm)
set t_RV=

" Use 2 spaces for <Tab> and :retab
set tabstop=2

" expand tabs to spaces
set expandtab

" Write swap file to disk after every 50 characters
set updatecount=50

" show line numbers
set number

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Go back to the position the cursor was on the last time this file was edited
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Avoid loading MatchParen plugin
let loaded_matchparen = 1

" netRW: Open files in a split window
let g:netrw_browse_split = 1

"
" MAPPINGS
"

" save changes
map ,s :w<CR>
" exit vim without saving any changes
map ,q :q!<CR>
" exit vim saving changes
map ,w :x<CR>
" switch to upper/lower window quickly
map <C-J> <C-W>j
map <C-K> <C-W>k
" use CTRL-F for omni completion
imap <C-F> 
" map ,f to display all lines with keyword under cursor and ask which one to
" jump to
nmap ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" page down with <Space>
nmap <Space> <PageDown>
" page up with -
noremap - <PageUp>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" Open URL in the current line
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call HandleURI()<CR>


"
" SuperTab configuration
"

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"
" NERDTree configuration
"

" Increase window size to 35 columns
let NERDTreeWinSize=35

" map <F7> to toggle NERDTree window
nmap <silent> <F7> :NERDTreeToggle<CR>

" Configure vim so it can be called from crontab -e
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*

"
" SnipMate configuration
"
let g:snips_author = 'Jon Duell'

"
" PHPFolding configuration
"
map <F6> <Esc>:EnablePHPFolds<Cr>
