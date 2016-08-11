" ----------------------------------------
" Vundle
" ----------------------------------------

set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" lets install some bundles, shall we?

" Display {{{

" Powerline {{{

Plugin 'Lokaltog/vim-powerline'

" let g:Powerline_symbols = 'fancy'
" let g:Powerline_dividers_override = ['', '', '', '']

" }}}
" Solarized {{{

Plugin 'altercation/vim-colors-solarized.git'

" }}}
" Luna {{{

Plugin 'Pychimp/vim-luna.git'

" }}}

" }}}

" Movement {{{

" CtrlP configuration {{{

Plugin 'kien/ctrlp.vim.git'

let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '\vsites/default/files$'
let g:ctrlp_prompt_mappings = {
    \ 'ToggleType(1)':        ['<c-s>'],
    \}
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" if executable('ag')
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" end
" let g:ctrlp_user_command = {
"   \ 'types': {
"     \ 1: ['.git', 'cd %s && cd `git rev-parse --show-toplevel` && (git submodule --quiet foreach git ls-files -oc --exclude-standard; git ls-files -oc --exclude-standard;)'],
"     \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"   \ 'fallback': 'find %s -type f'
"   \ }

" }}}
" Ag {{{

Plugin 'rking/ag.vim.git'

" }}}
" Signature {{{

Plugin 'kshenoy/vim-signature.git'

" }}}
" EasyMotion {{{

Plugin 'Lokaltog/vim-easymotion.git'

let g:EasyMotion_leader_key = '<Leader>f'

" }}}
" MatchIt {{{

Plugin 'edsono/vim-matchit.git'

" }}}
" Unimpaired {{{

Plugin 'tpope/vim-unimpaired.git'

" }}}
" Vinegar {{{

Plugin 'tpope/vim-vinegar.git'

" }}}

" }}}

" Completion {{{

" Ultisnips {{{

Plugin 'SirVer/ultisnips.git'
Plugin 'honza/vim-snippets.git'

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger="<c-j>"

" }}}
" SuperTab configuration {{{

" Plugin 'ervandew/supertab.git'

" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" let g:SuperTabCrMapping = 0

" }}}
" PHP Complete {{{

Plugin 'shawncplus/phpcomplete.vim.git'

" }}}
" You Complete Me {{{

" Plugin 'Valloric/YouCompleteMe'

" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_add_preview_to_completeopt = 1

" }}}
" NeoComplete {{{

Plugin 'Shougo/neocomplete.vim.git'

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#tags#cache_limit_size = 1000000

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" }}}

" }}}

" Editing {{{

" Repeat {{{

Plugin 'tpope/vim-repeat.git'

" }}}
" Surround {{{

Plugin 'tpope/vim-surround.git'

" }}}
" Tabular {{{

Plugin 'godlygeek/tabular.git'

" }}}
" Gundo {{{

Plugin 'sjl/gundo.vim.git'

" }}}
" Commentary {{{

Plugin 'tpope/vim-commentary.git'

" }}}
" Ragtag {{{

Plugin 'tpope/vim-ragtag.git'

" }}}
" Toggle {{{

Plugin 'vim-scripts/Toggle.git'

" }}}
" Vdebug {{{

" Plugin 'joonty/vdebug.git'
let g:vdebug_keymap = {
\    "run" : "<leader>dr",
\    "run_to_cursor" : "<leader>dt",
\    "step_over" : "<leader>do",
\    "step_into" : "<leader>di",
\    "step_out" : "<leader>du",
\    "close" : "<leader>dx",
\    "detach" : "<leader>dd",
\    "set_breakpoint" : "<leader>db",
\    "get_context" : "<leader>dc",
\    "eval_under_cursor" : "<leader>de",
\}
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : '',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

" }}}
" Abolish {{{

Plugin 'tpope/vim-abolish.git'

" }}}

" }}}

" Tags {{{

" Tagbar {{{

Plugin 'majutsushi/tagbar.git'

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

Plugin 'vim-scripts/AutoTag.git'

let autotagCtagsCmd = '/usr/local/bin/ctags  --langmap=php:.engine.inc.module.theme.php.install.test.profile --php-kinds=cdfi --languages=php --recurse --exclude="\.git" --exclude="\.svn" --exclude="\.hg" --exclude="\.bzr" --exclude="CVS" --tag-relative=yes --regex-PHP="/abstract\s+class\s+([^ ]+)/\1/c/" --regex-PHP="/interface\s+([^ ]+)/\1/c/" --regex-PHP="/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)function\s+\&?\s*([^ (]+)/\2/f/"'

" }}}

" }}}

" Version Control {{{

" Fugitive {{{

Plugin 'tpope/vim-fugitive.git'

" }}}
" GitV {{{

Plugin 'gregsexton/gitv.git'

let g:Gitv_DoNotMapCtrlKey = 1

" }}}
" Git syntax {{{

Plugin 'tpope/vim-git.git'

" }}}
" Git Signify {{{

Plugin 'mhinz/vim-signify.git'

let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_sign_overwrite = 0

" }}}

" }}}

" File Types {{{

" Less Syntax {{{

Plugin 'groenewege/vim-less.git'

" }}}
" Sass Syntax {{{

Plugin 'tpope/vim-haml.git'

" }}}
" Vim help files {{{

Plugin 'juanpabloaj/help.vim.git'

" }}}
" PIV {{{

Plugin 'duellj/PIV.git'

let PHP_vintage_case_default_indent = 1
let PIVAutoClose = 0
let PHP_autoformatcomment = 0

" }}}
" Php Documentor {{{

Plugin 'tobyS/pdv.git'
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

" }}}
" Drush{{{

Plugin 'duellj/drush.vim.git'

" }}}
" Ini syntax {{{

Plugin 'duellj/ini-syntax-definition.git'

" }}}
" jQuery {{{

Plugin 'itspriddle/vim-jquery.git'

" }}}
" Markdown {{{

Plugin 'tpope/vim-markdown.git'
Plugin 'nelstrom/vim-markdown-folding.git'

" }}}
" Twig {{{

Plugin 'evidens/vim-twig.git'

" }}}

" }}}

" Misc {{{

" Syntastic {{{

Plugin 'duellj/syntastic.git'

let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_php_phpcs_args=' --report=csv --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_warning_symbol='⚠'

" }}}
" Scratch Buffer{{{

Plugin 'vim-scripts/scratch.vim.git'

" }}}
" Vitality (iterm/tmux itegration) {{{

Plugin 'sjl/vitality.vim.git'

let g:vitality_fix_focus = 0

" }}}
" Sensible Defaults {{{

Plugin 'tpope/vim-sensible.git'

" }}}
" Scriptease {{{

Plugin 'tpope/vim-scriptease.git'

" }}}
" Tbone (tmux integration) {{{

Plugin 'tpope/vim-tbone.git'

" }}}

" }}}

call vundle#end()
