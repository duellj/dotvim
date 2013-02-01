" ----------------------------------------
" Vundle
" ----------------------------------------

set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'


" lets install some bundles, shall we?

" Display {{{

" Powerline {{{

Bundle 'Lokaltog/vim-powerline'

let g:Powerline_symbols = 'fancy'

" }}}
" Solarized {{{

Bundle 'altercation/vim-colors-solarized.git'

" }}}

" }}}

" Movement {{{

" CtrlP configuration {{{

Bundle 'kien/ctrlp.vim.git'

let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '\vsites/default/files$'
" let g:ctrlp_user_command = {
"   \ 'types': {
"     \ 1: ['.git', 'cd %s && cd `git rev-parse --show-toplevel` && (git submodule --quiet foreach git ls-files -oc --exclude-standard; git ls-files -oc --exclude-standard;)'],
"     \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"   \ 'fallback': 'find %s -type f'
"   \ }

" }}}
" Ack {{{

Bundle 'mileszs/ack.vim.git'

" open Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" }}}
" Signature {{{

Bundle 'kshenoy/vim-signature.git'

" }}}
" EasyMotion {{{

Bundle 'Lokaltog/vim-easymotion.git'

let g:EasyMotion_leader_key = '<Leader>m'

" }}}
" MatchIt {{{

Bundle 'edsono/vim-matchit.git'

" }}}
" Unimpaired {{{

Bundle 'tpope/vim-unimpaired.git'

" }}}

" }}}

" Completion {{{

" Ultisnips {{{

Bundle 'duellj/ultisnips.git'

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'

" }}}
" SuperTab configuration {{{

Bundle 'ervandew/supertab.git'

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabCrMapping = 0

" }}}

" }}}

" Editing {{{

" Sideways {{{

Bundle 'AndrewRadev/sideways.vim.git'

" }}}
" Repeat {{{

Bundle 'tpope/vim-repeat.git'

" }}}
" Surround {{{

Bundle 'tpope/vim-surround.git'

" }}}
" Tabular {{{

Bundle 'godlygeek/tabular.git'

" }}}
" Gundo {{{

Bundle 'sjl/gundo.vim.git'

" }}}
" Commentary {{{

Bundle 'tpope/vim-commentary.git'

" }}}
" Ragtag {{{

Bundle 'tpope/vim-ragtag.git'

" }}}
" Toggle {{{

Bundle 'vim-scripts/Toggle.git'

" }}}
" Pasta! {{{

Bundle 'sickill/vim-pasta'

" }}}

" }}}

" Tags {{{

" Tagbar {{{

Bundle 'majutsushi/tagbar.git'

let g:tagbar_foldlevel = 0
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
let g:tagbar_type_javascript = {
  \ 'ctagstype' : 'JavaScript',
  \ 'kinds'     : [
    \ 'o:objects',
    \ 'f:functions',
    \ 'a:arrays',
    \ 's:strings'
  \ ]
\ }

" }}}
" Autotag {{{

Bundle 'vim-scripts/AutoTag.git'

let autotagCtagsCmd = "/usr/local/bin/ctags --langmap=php:.install.inc.module.theme.php --php-kinds=cdfi --languages=php"

" }}}

" }}}

" Version Control {{{

" Fugitive {{{

Bundle 'tpope/vim-fugitive.git'

" }}}
" GitV {{{

Bundle 'gregsexton/gitv.git'

let g:Gitv_DoNotMapCtrlKey = 1

" }}}
" Splice (3-way merge) {{{

Bundle 'sjl/splice.vim.git'

" }}}
" Git syntax {{{

Bundle 'tpope/vim-git.git'

" }}}

" }}}

" File Types {{{

" Less Syntax {{{

Bundle 'groenewege/vim-less.git'

" }}}
" Sass Syntax {{{

Bundle 'tpope/vim-haml.git'

" }}}
" Vim help files {{{

Bundle 'juanpabloaj/help.vim.git'

" }}}
" PIV {{{

Bundle 'duellj/PIV.git'

let PHP_vintage_case_default_indent = 1
let PIVAutoClose = 0

" }}}
" Php Documentor {{

Bundle 'tobyS/pdv.git'
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

" }}}
" Drush{{{

Bundle 'duellj/drush.vim.git'

" }}}
" Ini syntax {{{

Bundle 'duellj/ini-syntax-definition.git'

" }}}
" jQuery {{{

Bundle 'itspriddle/vim-jquery.git'

" }}}
" Markdown {{{

Bundle 'nelstrom/vim-markdown-folding.git'

" }}}

" }}}

" Misc {{{

" Syntastic {{{

Bundle 'duellj/syntastic.git'

let g:syntastic_enable_signs=1
let g:syntastic_phpcs_conf=' --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'

" }}}
" Notes {{{

Bundle 'xolox/vim-notes.git'

" }}}
" Scratch Buffer{{{

Bundle 'vim-scripts/scratch.vim.git'

" }}}
" Vitality (iterm/tmux itegration) {{{

Bundle 'sjl/vitality.vim.git'

let g:vitality_fix_focus = 0

" }}}
" Sensible Defaults {{{

Bundle 'tpope/vim-sensible.git'

" }}}
" Slueth (auto determine tabwidth) {{{

Bundle 'tpope/vim-sleuth.git'

" }}}

" }}}
