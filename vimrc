"
" MAIN CUSTOMIZATION FILE
"

" Preliminary definitions {{{
" Active pathogen bundle manager
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" Enable loading filetype and indentation plugins
filetype plugin indent on

" Don't need VI
set nocompatible

" Turn syntax highlighting on
syntax on
"}}}

" GLOBAL SETTINGS {{{

colorscheme tomorrow_night
set background=dark

set statusline=%f%m%r%h%w%=
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%y\ (line\ %l\/%L,\ col\ %c)

set autoindent              " Set autoindent for all files
set autowrite               " Write contents of the file, if it has been modified, on buffer exit
set enc=utf-8               " Use UTF-8 as the default buffer encoding
set history=100             " Remember up to 100 'colon' commmands and search patterns
set incsearch               " Enable incremental search
set ignorecase              " Enable case insensitive search
set smartcase               " Ignore ignorecase when search pattern contains an upper case character
set laststatus=2            " Always show status line, even for one window
set shiftwidth=2            " Use 2 spaces for (auto)indent
set tabstop=2               " Use 2 spaces for <Tab> and :retab
set expandtab               " expand tabs to spaces
set matchtime=3             " Jump to matching bracket for 3/10th of a second (works with showmatch)
set hlsearch                " Highlight results of a search
set wrap                    " Wrap long lines
set textwidth=80            " Wrap at 80 characters
set nrformats=octal,hex     " Enable CTRL-A/CTRL-X to work on octal and hex numbers
set pastetoggle=<F10>       " Use F10 to toggle 'paste' mode
set ruler                   " Show line, column number, and relative position within a file in the status line
set number                  " show line numbers
set scrolloff=3             " Scroll when cursor gets within 3 characters of top/bottom edge
set shiftround              " Round indent to multiple of 'shiftwidth' for > and < commands
set showcmd                 " Show (partial) commands (or size of selection in Visual mode) in the status line
set showmatch               " When a bracket is inserted, briefly jump to a matching one
set t_RV=                   " Don't request terminal version string (for xterm)
set updatecount=50          " Write swap file to disk after every 50 characters
set cursorline              " Highlight cursor line
set directory=~/.vimbackup/ " Save backups outside of current directory
set wildmenu                " More useful command-line completion
set fo=crq
set list
set listchars=tab:▸\ ,trail:· " Highlight extra whitespace
set undofile
set undodir=~/.vimundo/
set autoread

set shell=/bin/bash

set backspace=indent,eol,start       " Allow backspacing over everything
set completeopt=menu,longest,preview " Insert mode completion options

" Make horizontal scrolling less horrible.
set sidescroll=1
set sidescrolloff=10

" Ignore VCS and image files during wildmode (and command-t)
set wildignore=*.git,*.hg,*.svn,*.jpg,*.jpeg,*.gif,*.png

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

" Configure vim so it can be called from crontab -e
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*

" Find tags file in parent directories
set tags=./tags;

" Highlight statusbar when in insert mode
au InsertEnter * hi StatusLine ctermfg=196 guifg=#CD5907
au InsertLeave * hi StatusLine ctermfg=130 guifg=#8e8f8d

"}}}

" MAPPINGS {{{
let mapleader = ","

" save changes
map <leader>s :w<CR>

" exit vim 
map <leader>q :q<CR>

" exit vim saving changes
map <leader>w :x<CR>

" switch to split windows quickly
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" use CTRL-F for omni completion
imap <C-F> 

" map <leader>f to display all lines with keyword under cursor and ask which one to
" jump to
nmap <leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" reselect text that was just pasted
nnoremap <leader>v V`]

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Map <tab to match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" page down with <Space>
nmap <Space> <PageDown>

" page up with -
noremap - <PageUp>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" open URL in the current line
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

" Change directory to directory of current file
map <Leader>cd :cd %:p:h<CR>

" open Ack
nnoremap <leader>a :Ack 
" run Ack against word under cursor
nnoremap <leader>A :Ack <c-r><c-w><CR>

" write file as sudo
cmap w!! w !sudo tee % >/dev/null

"Shortcut for editing  vimrc file in a new tab
nmap <leader>ev :tabedit $MYVIMRC<cr>

" Quick returns
inoremap <c-cr> <esc>A<cr>

" Pulls in Drupal variables (from Drush) and outputs variable_set() calls for
" each variable.
" Todo: Should probably check to see if drush can bootstrap
function! s:DrushVariableGet(args)
  exec "normal o"
  exec "r !drush variable-get --pipe " . a:args . " | sed 's/$variables\\[\\(.*\\)\\] = /variable_set(\\1, /' | sed 's/;$/);/'"
  exec "normal ={"
endfunction
command! -bang -nargs=* -complete=file Dvar call s:DrushVariableGet(<q-args>)

" Add an 'in next ()' text object, e.g.
"   din( - 'Delete in next ()'
"   vin( - 'Select in next ()'
"   cin( - 'Change in next () (great for function calls)'
vnoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>

" Disable search highlighting
nnoremap <esc> :nohl<CR>

" Go away, help key.
set fuoptions=maxvert,maxhorz
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Show the syntax rule for text under the cursor
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc
nno ß :call SynStack()<CR>

""""""""""""""""""""""""""""""
" => Phpcs                {{{
" see: http://www.koch.ro/blog/index.php?/archives/62-Integrate-PHP-CodeSniffer-in-VIM.html
""""""""""""""""""""""""""""""
function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('/usr/local/zend/bin/phpcs --report=csv --standard=Drupal '.l:filename)
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
endfunction

"set errorformat+="%f"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,"%m"
set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[a-zA-Z0-9_.-]
command! Phpcs execute RunPhpcs()
nnoremap <leader>ps :Phpcs<CR>
"}}}

"}}}

" Filetype configuration {{{

" Vim {{{
au FileType vim setlocal foldmethod=marker
" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
if has("autocmd")
 augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
 augroup END
endif
"}}}

" PHP/Drupal {{{
au BufRead,BufNewFile *.module setfiletype php
au BufRead,BufNewFile *.theme setfiletype php
au BufRead,BufNewFile *.inc setfiletype php
au BufRead,BufNewFile *.install setfiletype php
au BufRead,BufNewFile *.test setfiletype php
au BufRead,BufNewFile *.profile setfiletype php
au BufRead,BufNewFile *.tpl.php setfiletype php
au BufRead,BufNewFile *.make setfiletype dosini
au BufRead,BufNewFile *.info setfiletype ini
" }}}

" LessCSS {{{
au BufRead,BufNewFile *.less setfiletype less
au FileType less setlocal foldmethod=marker foldmarker={,}

" Auto compress less files
"autocmd FileWritePost,BufWritePost *.less :call LessCSSCompress()
"function! LessCSSCompress()
  "let cwd = expand('<afile>:p:h')
  "let name = expand('<afile>:t:r')
  "if (executable('lessc'))
    "cal system('lessc '.cwd.'/'.name.'.less > '.cwd.'/'.name.'.css &')
  "endif
"endfunction
" }}}

" JavaScript {{{
au FileType javascript setlocal foldmethod=marker foldmarker={,}
" }}}

" Markdown {{{
au BufRead,BufNewFile *.md :set filetype=markdown
au BufRead,BufNewFile *.md :setlocal spell spelllang=en
" }}}

" Word Docs (haha suckit Office) {{{
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
autocmd BufReadPre *.docx set ro
autocmd BufReadPre *.docx set hlsearch!
autocmd BufReadPost *.docx %!antiword "%"
" }}}

" Quickfix {{{
" Clean up the QuickFix window (great for Ack)
au Filetype qf setl nolist
au Filetype qf setl nocursorline
au Filetype qf setl nowrap
" }}}
" }}}

" Plugin configuration {{{

" MatchIt configuration {{{
let b:match_ignorecase=0
" }}}

" SuperTab configuration {{{
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" }}}

" NERDTree configuration {{{
" Increase window size to 30 columns
let NERDTreeWinSize=30

" map <F7> to toggle NERDTree window
nmap <silent> <F7> :NERDTreeToggle<CR>
" }}}

" SnipMate configuration {{{
let g:snips_author = 'Jon Duell'
" }}}

" PHPFolding configuration {{{
map <F6> <Esc>:EnablePHPFolds<Cr>
" }}}

" TagBar configuration {{{
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
map <F4> :TagbarToggle<cr>
" }}}

" AutoTag configuration {{{
let autotagCtagsCmd = "/usr/local/bin/ctags --langmap=php:.install.inc.module.theme.php --php-kinds=cdfi --languages=php"
" }}}

" IndentGuides configuration {{{
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" }}}

" CheckSyntax configuration {{{
nnoremap <F3> :CheckSyntax<CR>
" }}}

" Gundo configuration {{{
nnoremap <F5> :GundoToggle<CR>
" }}}

" AutoComplPop configuration {{{
let g:acp_enableAtStartup = 1
let g:acp_completeoptPreview = 1
let g:acp_completeOption = ".,w,b,k,t,i"
let g:acp_behaviorSnipmateLength = 1
" }}}

" VimPager configuration {{{
let vimpager_use_gvim = 1
" }}}

" Syntastic configuration {{{
let g:syntastic_enable_signs=1
" }}}

" EasyMotion configuration {{{
let g:EasyMotion_leader_key = '<Leader>m'
" }}}

" delimitMate configuration {{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}

" BufExplorer configuration {{{
let g:bufExplorerShowRelativePath=1
" }}}

" Commentary configuration {{{
autocmd FileType php set commentstring=//\ %s
" }}}
" }}}
