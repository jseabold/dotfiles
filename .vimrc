colors koehler
set shiftwidth=4
set expandtab
set tabstop=4
set autoindent
set softtabstop=4 "Multiple spaces are seen as tabstops so <BS> deletes the four together"

if has("autocmd")
  filetype plugin indent on
endif

"Hitting zz in normal mode will remove all consecutive whitespace in a line
"and make it single whitespace
:map zz :s![^ ]\zs  \+! !g<CR>
"Replace all consecutive whitespace, with commas whitespace
:map xx :s![^ ]\zs \+!, !g<CR>
"Take a 'column' of data and replace line endings with comma-delimited
:map xc :%s/\n/, /g<CR>
"Type Cc on a bunch of commits and it reverse them and turns them into
"cherry-picks
:map cc :%s/\(^\*\s\)\(.\{7}\)\(.*\)/git cherry-pick \2/<CR> :g/^/m0<CR>
"xz truncates the line at the last space before or at 79 characters
:map zx :s/\(^.\{,78\}\)\s/\1\r <CR>j

"Go to the last whitespace before the line above the cursor and enter
"a carraige return. Needs to be at beginning of line. not sure why i can't
"move the cursor yet
:map rr ?\%<79c\s<CR>ciw<CR><ESC>j<C-0>

:set ignorecase
:set smartcase

if has('gui_running')
  set guioptions-=T  " no toolbar
endif

call pathogen#infect()

" from http://stackoverflow.com/questions/14779299/syntax-highlighting-randomly-disappears-during-file-saving
" fix highlighting by hitting F9 when it messes up
noremap <F9> <Esc>:syntax sync fromstart<CR>
inoremap <F9> <C-o>:syntax sync fromstart<CR>

" for latex-suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
