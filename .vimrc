colors koehler
set shiftwidth=4
set expandtab
set tabstop=4
set autoindent
set softtabstop=4 "Multiple spaces are seen as tabstops so <BS> deletes the four together"

" windows remain the same size after a split
set equalalways

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" show matching parens
set showmatch
set wildignore=*.swp,*.bak,*pyc
set title

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
:map cc :%s/\(^\)\(.\{7}\)\(.*\)/git cherry-pick \2/<CR> :g/^/m0<CR>
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

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

let mapleader = ","

" Open URL in browser
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!chromium-browser ".line
endfunction

map <Leader>w :call Browser()<CR>

" syntastic
" 203 whitespace before :
let g:syntatsic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E203,E226,E121"'

" vim-jedi
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" ii gets you out of edit and into normal mode
imap ii <Esc>

" font stuff, desktop can handle smaller font
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "skipper-desktop"
    if has("gui_running")
    if has("gui_gtk2")
        set guifont=Monospace\ 9
    endif
    endif
endif

" better indents for HTML
autocmd FileType html,mustache setlocal shiftwidth=2 tabstop=2
