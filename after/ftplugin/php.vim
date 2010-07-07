" Fix matchpairs for PHP (for matchit.vim plugin)
if exists("loaded_matchit")
    let b:match_skip = 's:comment\|string'
    let b:match_words = '<?\(php\)\?:?>,\<switch\>:\<endswitch\>,' .
        \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
        \ '\<while\>:\<endwhile\>,\<do\>:\<while\>,' .
        \ '\<for\>:\<endfor\>,\<foreach\>:\<endforeach\>' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/?][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,' .
        \ '<:>'
endif

set autoindent

" Having both filetype plugin and filetype indent causes indent not to work
" properly for php files (only non *.php files).  This resets back to proper
" format options
set formatoptions=qrowcb

" Uncomment the following function and option if you do not want built-in
" classes and methods appearing in omni completion lists
"
"function! MyPHPComplete(findstart, base)
"	if !exists('g:php_builtin_functions')
"		call phpcomplete#LoadData()
"	endif
"	let g:php_builtin_object_functions = {}
"
"	let result = phpcomplete#CompletePHP(a:findstart, a:base)
"	return result
"endfunction
"setlocal ofu=MyPHPComplete



