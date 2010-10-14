"
" Filetype detection
"
augroup filetypedetect

	" Detect .txt as 'text'
  autocmd! BufNewFile,BufRead *.txt setfiletype text

	" Detect .phps as 'php'
	au BufRead,BufNewFile *.phps setfiletype php

	" Detect .module as 'php', for Drupal
	au BufRead,BufNewFile *.module setfiletype php

	" Detect .theme as 'php', for Drupal
	au BufRead,BufNewFile *.theme setfiletype php

	" Detect .inc as 'php', for Drupal
	au BufRead,BufNewFile *.inc setfiletype php

	" Detect .install as 'php', for Drupal
	au BufRead,BufNewFile *.install setfiletype php

	" Detect .test as 'php', for Drupal
	au BufRead,BufNewFile *.test setfiletype php

	" Detect .profile as 'php', for Drupal
	au BufRead,BufNewFile *.profile setfiletype php

	" Detect .dwt as 'html'
	au BufRead,BufNewFile *.dwt setfiletype html


augroup END
