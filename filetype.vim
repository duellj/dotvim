"
" Filetype detection
"
augroup filetypedetect

	" Detect .txt as 'text'
  autocmd! BufNewFile,BufRead *.txt setfiletype text

  " Add drupal and html filetype to php files for snipets
  au BufRead,BufNewFile *.php setfiletype php.drupal

	" Detect .phps as 'php'
	au BufRead,BufNewFile *.phps setfiletype php

	" Detect .module as 'php', for Drupal
	au BufRead,BufNewFile *.module setfiletype php.drupal

	" Detect .theme as 'php', for Drupal
	au BufRead,BufNewFile *.theme setfiletype php.drupal

	" Detect .inc as 'php', for Drupal
	au BufRead,BufNewFile *.inc setfiletype php.drupal

	" Detect .install as 'php', for Drupal
	au BufRead,BufNewFile *.install setfiletype php.drupal

	" Detect .test as 'php', for Drupal
	au BufRead,BufNewFile *.test setfiletype php.drupal

	" Detect .profile as 'php', for Drupal
	au BufRead,BufNewFile *.profile setfiletype php.drupal

  " Detect .tpl.php as 'php' and 'html'
  au BufRead,BufNewFile *.tpl.php setfiletype php.drupal.html

	" Detect .dwt as 'html'
	au BufRead,BufNewFile *.dwt setfiletype html

augroup END
