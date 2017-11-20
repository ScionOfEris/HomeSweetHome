set background=dark

syntax on

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" having strange auto indent issues....
set paste
set noautoindent
set nocindent
set nosmartindent

" no auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Get Pathogen to work, to help with other plugins.
execute pathogen#infect()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

