"
" Filetype detection
"
augroup filetypedetect

	" Detect .txt as 'text'
  autocmd! BufNewFile,BufRead *.txt setfiletype text

  " Add drupal and html filetype to php files for snipets
  au BufRead,BufNewFile *.php setfiletype php

	" Detect .phps as 'php'
	au BufRead,BufNewFile *.phps setfiletype php

	" Detect .module as 'php'
	au BufRead,BufNewFile *.module setfiletype php

	" Detect .theme as 'php'
	au BufRead,BufNewFile *.theme setfiletype php

	" Detect .inc as 'php'
	au BufRead,BufNewFile *.inc setfiletype php

	" Detect .install as 'php'
	au BufRead,BufNewFile *.install setfiletype php

	" Detect .test as 'php'
	au BufRead,BufNewFile *.test setfiletype php

	" Detect .profile as 'php'
	au BufRead,BufNewFile *.profile setfiletype php

  " Detect .tpl.php as 'php'
  au BufRead,BufNewFile *.tpl.php setfiletype php

	" Detect .dwt as 'html'
	au BufRead,BufNewFile *.dwt setfiletype html

augroup END
