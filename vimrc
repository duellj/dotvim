"
" MAIN CUSTOMIZATION FILE
"

" Bundles!
source ~/.vim/vundle.vim

" Preliminary definitions {{{

" Automatically detect file types. (must turn on after Vundle)
filetype plugin indent on

syntax on
autocmd BufEnter * :syntax sync fromstart
"}}}

" Global settings {{{


set enc=utf-8                   " Use UTF-8 as the default buffer encoding
set history=1000                " Remember up to 100 'colon' commmands and search patterns
set list                        " Show hidden characters
set hidden                      " Manage multiple buffer history
set matchtime=3                 " Jump to matching bracket for 3/10th of a second (works with showmatch)
set number                      " show line numbers
set relativenumber              " show line numbers
set shell=/bin/bash
set tags=./tags;                " Find tags file in parent directories
set cursorline                  " Highlight cursor line

" Insert mode completion options
set completeopt=menu,longest,preview

" Allow local .vimrc files per directory
set exrc
set secure

" Always spellcheck
set spell

" Leaders {{{

let mapleader = ","

" }}}

" Colorscheme {{{

set background=dark
colorscheme solarized
let g:solarized_termcolors=256

" Ensure git gutter has same background as line numbers for solarized.
" see https://github.com/altercation/vim-colors-solarized/pull/62
highlight clear SignColumn

" Allow background image from term to bleed through
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

" }}}

" Tabs, spaces {{{

set shiftwidth=2            " Use 2 spaces for (auto)indent
set shiftround              " Round indent to multiple of 'shiftwidth' for > and < commands
set tabstop=2               " Use 2 spaces for <Tab> and :retab
set expandtab               " expand tabs to spaces
set wrap                    " Wrap long lines
set textwidth=80            " Wrap at 80 characters
set formatoptions=crqn1j

" }}}

" Wildmenu {{{

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

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.cache/vim/viminfo

" Go back to the position the cursor was on the last time this file was edited
augroup line_return
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif
augroup END

" Configure vim so it can be called from crontab -e
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*

" Set backup directories
let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif 

" }}}

"}}}

" Search/replace {{{

" Highlight results of a search
set hlsearch

" Disable search highlighting
nnoremap <esc> :nohlsearch<CR>

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

" map <leader>w to display all lines with keyword under cursor and ask which one to
" jump to
nnoremap <leader>w [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

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

" Explore directory with "-"
noremap - :Ex<cr>

" Make horizontal scrolling less horrible.
set sidescroll=1

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

" Always open vertical splits on the right
set splitright

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

" Plugin Mappings {{{

nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>z :CtrlPTag<CR>

nnoremap <leader>a :Ag 
" run Ag against word under cursor
nnoremap <leader>A :Ag <c-r><c-w><CR>

nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>

nnoremap <leader>u :GundoToggle<CR>

nnoremap <leader>t :TagbarToggle<cr>

" Drag Visuals 
 vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

" }}}

" }}}

" Filetype configuration {{{

" Vim {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker

  " Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
  " if has("autocmd")
  "   autocmd bufwritepost .vimrc source ~/.vimrc
  " endif
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

  " au FileType php au BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType php set commentstring=//\ %s

  autocmd FileType php set nosmartindent
  autocmd FileType php set autoindent
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
  au Filetype less nnoremap <buffer> <localleader>c :w <BAR> !lessc % > %:p:h/%:t:r.css<cr><space>

  autocmd FileType less,css setlocal omnifunc=csscomplete#CompleteCSS
augroup END

" }}}

" JavaScript {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}

  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

" }}}

" Markdown {{{

augroup ft_markdown
  au!

  au Filetype markdown setlocal spell spelllang=en
  au Filetype markdown setlocal conceallevel=2

  " QuickLook preview
  au Filetype markdown nnoremap <leader>p :!qlmanage -p % >& /dev/null<CR>

  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
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
" Clean up the QuickFix window (great for Ag)

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

  au FileType gitcommit setlocal textwidth=80 wrap spell
augroup END

" }}}

" gitrebase {{{

augroup ft_gitrebase
  au!

  nnoremap <buffer> <silent> S :Cycle<CR>
augroup END

" }}}

" MySQL {{{

augroup ft_mysql
  nnoremap <buffer> <LocalLeader>w :0,$Twrite<cr>
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

" Ini {{{
augroup ft_tmux
  autocmd FileType ini set commentstring=;\ %s
augroup END 
" }}}

" Python {{{
augroup ft_python
  autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
augroup END
" }}}

" HTML {{{
augroup ft_html
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
augroup END
" }}}

" }}}

" Functions {{{

" Strip trailing whitespace {{{

function! DeleteTrailingWS()
  %s/\s\+$//ge
  exe "normal g;"
endfunc
nnoremap <Leader>w :silent call DeleteTrailingWS()<CR>

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

" "Focus" the current line. {{{
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line. My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

" expand tabs into spaces
    let onetab = strpart(' ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" Pulse Line {{{

function! s:Pulse() " {{{
    let current_window = winnr()
    windo set nocursorline
    execute current_window . 'wincmd w'
    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 9
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()

" }}}

" Better Fold Text{{{
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" }}}

" Remove all buffers not currently open
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim

function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

" }}}
