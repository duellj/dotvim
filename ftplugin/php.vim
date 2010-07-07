"
" Settings for PHP filetype
"

" Load PHP dictionary for autocompletion
" Found here http://lerdorf.com/funclist.txt
" set dictionary=~/.vim/dic/php

" Turn on omni completion
autocmd FileType php set omnifunc=phpcomplete#CompletePHP


" Load PHP Documentor for VIM
source ~/.vim/php-doc.vim

" Set up automatic formatting
set formatoptions+=tcqlro

" Jump to matching bracket for 3/10th of a second (works with showmatch)
set matchtime=3
set showmatch

set autoindent
set smartindent

"
" Syntax options
"
" Enable folding of class/function blocks
let php_folding = 1

" Do not use short tags to find PHP blocks
let php_noShortTags = 1

" Highlight SQL inside PHP strings
let php_sql_query=1

" Highlight HTML in strings
let php_htmlInStrings=1

"
" Mapping
"
" Map {'s
:inoremap {      {}<Left>
:inoremap {<CR>  {<CR>}<Esc>O
:inoremap {{     {
:inoremap {}     {}

"
" Linting
"
" Use PHP syntax check when doing :make
set makeprg=php\ -l\ %

" Parse PHP error output
set errorformat=%m\ in\ %f\ on\ line\ %l

" Function to locate endpoints of a PHP block {{{
function! PhpBlockSelect(mode)
	let motion = "v"
	let line = getline(".")
	let pos = col(".")-1
	let end = col("$")-1

	if a:mode == 1
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			let motion .= "l"
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			" do nothing
		else
			let motion .= "/?>/e\<CR>"
		endif
		let motion .= "o"
		if end > 0
			let motion .= "l"
		endif
		let motion .= "?<\\?php\\>\<CR>"
	else
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			" do nothing
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			let motion .= "h?\\S\<CR>""
		else
			let motion .= "/?>/;?\\S\<CR>"
		endif
		let motion .= "o?<\\?php\\>\<CR>4l/\\S\<CR>"
	endif

	return motion
endfunction
" }}}

" PhpAlign - Correct aligns blocks of code {{{
func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*=>\{0,1\}.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"
    
	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\) *=>\{0,1\}.*$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*.* *\(=>\{0,1\}\).*$', '\1', "")
        let l:linevalue = substitute (getline (l:line), '^\s*.* *=>\{0,1\}\s*\(.*\)$', '\1', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc
" }}}

" Map <CTRL>-a to (un-)comment function
vnoremap <C-a> :call PhpAlign()<CR>

" Mappings to select full/inner PHP block
nmap <silent> <expr> vaP PhpBlockSelect(1)
nmap <silent> <expr> viP PhpBlockSelect(0)
" Mappings for operator mode to work on full/inner PHP block
omap <silent> aP :silent normal vaP<CR>
omap <silent> iP :silent normal viP<CR>

" Mappings for PHP Documentor for VIM
inoremap <buffer> <C-P> <Esc>:call PhpDocSingle()<CR>i
nnoremap <buffer> <C-P> :call PhpDocSingle()<CR>
vnoremap <buffer> <C-P> :call PhpDocRange()<CR>
" Generate @uses tag based on inheritance info
let g:pdv_cfg_Uses = 1
" Set default Copyright
let g:pdv_cfg_Copyright = "Copyright (C) 2008 Jon Duell"

" Exuberant Ctags
"
" Map <F4> to re-build tags file
nmap <silent> <F4>
		\ :!ctags -f %:p:h/tags 
		\ --langmap="php:+.inc"
		\ -h ".php.inc" -R --totals=yes
		\ --tag-relative=yes --PHP-kinds=+cf-v %:p:h<CR>

" Set tag filename(s)
set tags=./tags,tags

" vim: set fdm=marker:
