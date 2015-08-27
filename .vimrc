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
:map <leader>zz :s![^ ]\zs  \+! !g<CR>
"Replace all consecutive whitespace, with commas whitespace
:map <leader>xx :s![^ ]\zs \+!, !g<CR>
"Take a 'column' of data and replace line endings with comma-delimited
:map <leader>xc :%s/\n/, /g<CR>
"Type Cc on a bunch of commits and it reverse them and turns them into
"cherry-picks
:map <leader>cc :%s/\(^\)\(.\{7}\)\(.*\)/git cherry-pick \2/<CR> :g/^/m0<CR>
"xz truncates the line at the last space before or at 79 characters
:map <leader>zx :s/\(^.\{,78\}\)\s/\1\r <CR>j

"Go to the last whitespace before the line above the cursor and enter
"a carraige return. Needs to be at beginning of line. not sure why i can't
"move the cursor yet
:map rr ?\%<79c\s<CR>ciw<CR><ESC>j<C-0>

:set ignorecase
:set smartcase

if has('gui_running')
  set guioptions-=T  " no toolbar
  set noeb vb
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

let mapleader = "\<Space>"

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
au BufNewFile,BufRead *.mustache setlocal ft=html
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" hack to add Cython to python ft instead of pyrex
" enabled code folding in python_editing.vim
au BufNewFile,BufRead *.pyx setlocal ft=python
au BufNewFile,BufRead *.pxi setlocal ft=python

" cvim
let g:C_UseTool_cmake = 'yes'
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        " for gx
        let g:netrw_browsex_viewer = "open"
    else
        let g:netrw_browsex_viewer = "xdg-open"
    endif

let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1

=======

" necomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
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
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
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

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

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
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" navigate between window panes with Ctrl + hjkl
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

let g:sql_type_default = 'pgsql'
set clipboard=unnamed
syntax enable
set background=dark
colorscheme solarized
>>>>>>> Completion. Re-map leader. Solarized scheme.
