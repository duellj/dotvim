"
" MAIN CUSTOMIZATION FILE
"

" Bundles!
source ~/.vim/vundle.vim

" Preliminary definitions {{{
" Don't need VI

" Turn syntax highlighting on

" Automatically detect file types. (must turn on after Vundle)
filetype plugin indent on

syntax on
autocmd BufEnter * :syntax sync fromstart
"}}}

" Global settings {{{


set enc=utf-8                   " Use UTF-8 as the default buffer encoding
set autoindent                  " Set autoindent for all files
set history=1000                " Remember up to 100 'colon' commmands and search patterns
set list                        " Show hidden characters
set listchars=tab:▸\ ,trail:·   " Highlight extra whitespace
set ruler                       " Show line, column number, and relative position within a file in the status line
set hidden                      " Manage multiple buffer history
set autowrite                   " Write contents of the file, if it has been modified, on buffer exit
set autoread                    " Auto reload files when changed on disk
set showmatch                   " When a bracket is inserted, briefly jump to a matching one
set matchtime=3                 " Jump to matching bracket for 3/10th of a second (works with showmatch)
set number                      " show line numbers
set backspace=indent,eol,start  " Allow backspacing over everything
set shell=/bin/bash
set showcmd                     " Show (partial) commands (or size of selection in Visual mode) in the status line
set laststatus=2                " Always show status line, even for one window
set tags=./tags;                " Find tags file in parent directories
set cursorline                  " Highlight cursor line

" Insert mode completion options
set completeopt=menu,longest,preview

" Allow local .vimrc files per directory
set exrc
set secure

" Leaders {{{

let mapleader = ","

" }}}

" Colorscheme {{{

set background=dark
colorscheme solarized
let g:solarized_termcolors=256

" }}}

" Tabs, spaces {{{

set shiftwidth=2            " Use 2 spaces for (auto)indent
set shiftround              " Round indent to multiple of 'shiftwidth' for > and < commands
set tabstop=2               " Use 2 spaces for <Tab> and :retab
set expandtab               " expand tabs to spaces
set wrap                    " Wrap long lines
set textwidth=80            " Wrap at 80 characters
set formatoptions=crqn1

" }}}

" Wildmenu {{{

set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

set wildignore=*.git,*.hg,*.svn          " Version control
set wildignore+=*.jpg,*.jpeg,*.gif,*.png " Images
set wildignore+=.DS_Store                " OSX

" }}}

" Backups {{{

set directory=~/.vimbackup/ " Save backups outside of current directory
set undodir=~/.vimundo/
set undofile

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Add session support
set sessionoptions=blank,buffers,curdir,folds,globals,help,resize,tabpages,winsize,winpos

" Go back to the position the cursor was on the last time this file was edited
augroup line_return
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif
augroup END

" Configure vim so it can be called from crontab -e
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*

" }}}

" Terminal {{{

  " Time out on key codes but not mappings.
  " Basically this makes terminal Vim work sanely.
  set notimeout
  set ttimeout
  set ttimeoutlen=100
" }}}

"}}}

" Search/replace {{{

" Highlight results of a search
set hlsearch

" Disable search highlighting
nnoremap <esc> :nohlsearch<CR>

" Enable incremental search
set incsearch

" Enable case insensitive search
set ignorecase

" Ignore ignorecase when search pattern contains an upper case character
set smartcase

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

" Always reuse flags.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" map <leader>f to display all lines with keyword under cursor and ask which one to
" jump to
nnoremap <leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Keep search matches in the middle of the window.
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Easily replace the current word.
nnoremap <Leader>S :%s/<c-r>=expand("<cword>")<cr>//c<left><left>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" }}}

" Moving {{{

" Much better then the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Sane movement keys.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" page down with <Space>
nnoremap <Space> <PageDown>

" page up with -
noremap - <PageUp>

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Make horizontal scrolling less horrible.
set sidescroll=1
set sidescrolloff=10

" Change directory to directory of current file
nnoremap <Leader>cd :cd %:p:h<CR>

" }}}

" Split windows {{{

" switch to split windows quickly
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h

" jump to tag in a split
nnoremap <silent> ,] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" }}}

" Quick editing {{{
"
nnoremap <silent> <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>ez :tabedit ~/.zshrc<CR>
nnoremap <silent> <leader>ed :tabedit ~/.drushrc.php<CR>
nnoremap <silent> <leader>et :tabedit ~/.tmux.conf<CR>
nnoremap <silent> <leader>ea :tabedit ~/.dotfiles/oh-my-zsh/custom/aliases.zsh<CR>

" }}}

" Writing/saving {{{

" save changes
noremap <leader>s :w<CR>

" exit vim 
noremap <leader>q :q<CR>

" exit vim saving changes
noremap <leader>w :x<CR>

" write file as sudo
cnoremap w!! w !sudo tee % >/dev/null

" }}}

" Text Objects {{{

" Next and Last {{{

" https://gist.github.com/3762227
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type in the current line, last acts
" on the previous object of the given type in the current line.
"
" Currently only works for (, [, {, b, r, B, ', and ".
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vil"  -> select inside last double quotes            print "hello ", name
"                                                                        C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "r"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" }}}

" }}}

" Mappings {{{

" reselect text that was just pasted
nnoremap <leader>v V`]

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" Yank selection to system clipboard
vnoremap Y "*y

" Quick returns
inoremap <c-cr> <esc>A<cr>

" Quick clear cache
nnoremap <leader>cc :!drush cc all<CR>

" Go away, help key.
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

"}}}

" Filetype configuration {{{

" Vim {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker

  " Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
  if has("autocmd")
    autocmd bufwritepost .vimrc source ~/.vimrc
  endif
augroup END

"}}}

" PHP/Drupal {{{

augroup ft_php
  au!

  au BufRead,BufNewFile *.module setfiletype php
  au BufRead,BufNewFile *.theme setfiletype php
  au BufRead,BufNewFile *.inc setfiletype php
  au BufRead,BufNewFile *.install setfiletype php
  au BufRead,BufNewFile *.test setfiletype php
  au BufRead,BufNewFile *.profile setfiletype php
  au BufRead,BufNewFile *.tpl.php setfiletype php
  au BufRead,BufNewFile *.make setfiletype dosini
  au BufRead,BufNewFile *.info setfiletype ini

  au FileType php au BufWritePre <buffer> :%s/\s\+$//e
augroup END

" }}}

" Less/CSS {{{

augroup ft_less
  au!

  au BufRead,BufNewFile *.less setfiletype less

  au FileType css,less setlocal foldmethod=marker
  au FileType css,less setlocal foldmarker={,}
  au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype less,css setlocal iskeyword+=-

  " Auto compress less files
  "autocmd FileWritePost,BufWritePost *.less :call LessCSSCompress()
  "function! LessCSSCompress()
    "let cwd = expand('<afile>:p:h')
    "let name = expand('<afile>:t:r')
    "if (executable('lessc'))
      "cal system('lessc '.cwd.'/'.name.'.less > '.cwd.'/'.name.'.css &')
    "endif
  "endfunction
augroup END

" }}}

" JavaScript {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
augroup END

" }}}

" Markdown {{{

augroup ft_markdown
  au!

  au BufNewFile,BufRead *.md setlocal filetype=markdown
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown

  au Filetype markdown setlocal spell spelllang=en

  " QuickLook preview
  nnoremap <leader>p :!qlmanage -p % >& /dev/null<CR>

  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>

  au FileType markdown au BufWrite <buffer> :call DeleteTrailingWS()
augroup END

" }}}

" Word Docs (haha suckit Office) {{{

augroup ft_doc
  au!

  autocmd BufReadPre *.doc set ro
  autocmd BufReadPre *.doc set hlsearch!
  autocmd BufReadPost *.doc %!antiword "%"
  autocmd BufReadPre *.docx set ro
  autocmd BufReadPre *.docx set hlsearch!
  autocmd BufReadPost *.docx %!antiword "%"
augroup END

" }}}

" Quickfix {{{
" Clean up the QuickFix window (great for Ack)

augroup ft_qf
  au!

  au Filetype qf setlocal colorcolumn=0
  au Filetype qf setlocal nolist
  au Filetype qf setlocal nocursorline
  au Filetype qf setlocal nowrap
augroup END

" }}}

" Snippets {{{

augroup ft_snippets
  au FileType snippets setlocal foldmethod=marker
augroup END

" }}}

" gitcommit {{{

augroup ft_gitcommit
  au!

  au FileType gitcommit setlocal textwidth=80 wrap
augroup END

" }}}

" gitrebase {{{

augroup ft_gitrebase
  au!

  nnoremap <buffer> <silent> S :Cycle<CR>
augroup END

" }}}

" {{{ Twig

augroup ft_twig
  au BufRead,BufNewFile *.twig setfiletype htmljinja
augroup END

" }}}

" {{{ ZSH

augroup ft_zsh
  au!

  au BufRead,BufNewFile *.zsh-theme setfiletype zsh
augroup END

" }}}

" tmux {{{
augroup ft_tmux
  au BufRead,BufNewFile .tmux.conf,tmux.conf* setfiletype tmux
augroup END
" }}}
" }}}

" Plugin configuration {{{
" Ack {{{

" open Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

nnoremap <leader>a :Ack 
" run Ack against word under cursor
nnoremap <leader>A :Ack <c-r><c-w><CR>

" }}}

" SuperTab configuration {{{

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabCrMapping = 0

" }}}

" PIV configuration {{{

nnoremap <F6> <Esc>:EnablePHPFolds<Cr>
let PHP_vintage_case_default_indent = 1
let PIVAutoClose = 0

" }}}

" TagBar configuration {{{

let g:tagbar_foldlevel = 0
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
nnoremap <leader>t :TagbarToggle<cr>

" }}}

" AutoTag configuration {{{

let autotagCtagsCmd = "/usr/local/bin/ctags --langmap=php:.install.inc.module.theme.php --php-kinds=cdfi --languages=php"

" }}}

" CheckSyntax configuration {{{

nnoremap <F3> :CheckSyntax<CR>

" }}}

" Gundo configuration {{{

nnoremap <leader>u :GundoToggle<CR>

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
let g:syntastic_phpcs_conf=' --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'

" }}}

" EasyMotion configuration {{{

let g:EasyMotion_leader_key = '<Leader>m'

" }}}

" BufExplorer configuration {{{

let g:bufExplorerShowRelativePath=1

" }}}

" Commentary configuration {{{

autocmd FileType php set commentstring=//\ %s
autocmd FileType ini set commentstring=;\ %s

" }}}

" CtrlP configuration {{{

let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

nnoremap <C-i> :CtrlPTag<CR>
" }}}

" Powerline {{{

let g:Powerline_symbols = 'fancy'

" }}}

" UltiSnips {{{

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'

" }}}

" gitv {{{

let g:Gitv_DoNotMapCtrlKey = 1

" }}}

" Sideways {{{

nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>

" }}}

" Vitality {{{

let g:vitality_fix_focus = 0

" }}}

" }}}

" Functions {{{

" open URL in the current line {{{

function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
nnoremap <Leader>w :call HandleURI()<CR>

" }}}

" Strip trailing whitespace {{{

function! DeleteTrailingWS()
  %s/\s\+$//ge
  exe "normal g;"
endfunc

" }}}

" Show syntax highlighting groups for word under cursor {{{

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-S-P> :call <SID>SynStack()<CR>

" }}}

" Allow quicklist to be operated on {{{

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" }}}

" }}}
