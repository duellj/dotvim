"
" General things that should be done at the very end, to override plugin
" settings
"

" Function to do <Tab> or completion, based on context {{{
function! CleverTab()
  if pumvisible()
    return "\<C-N>"
  endif
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  elseif exists('&omnifunc') && &omnifunc != ''
    return "\<C-X>\<C-O>"
  else
    return "\<C-N>"
  endif
endfunction
" }}}


"
" Map CTRL-B to snippetsEmu and use <Tab> for our smart completion
if exists('loaded_snippet')
	imap <C-B> <Plug>Jumper
endif
inoremap <Tab> <C-R>=CleverTab()<CR>

"
" Customize taglist settings
if exists('loaded_taglist')
	let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"
	let Tlist_Inc_Winwidth = 1
	let Tlist_Exit_OnlyWindow = 1
	let Tlist_File_Fold_Auto_Close = 1
	let Tlist_Enable_Fold_Column = 0
	let tlist_php_settings = 'php;c:class;d:constant;f:function'

	" map <F9> to toggle taglist window
	nmap <silent> <F9> :TlistToggle<CR>
endif

" Set CVS executable for VCSCommand plugin
if exists('loaded_VCSCommand')
	let VCSCommandCVSExec="cvs"
endif

" vim: set fdm=marker:
