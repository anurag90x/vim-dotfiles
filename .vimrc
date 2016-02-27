set nocompatible
set swapfile
set dir=~/tmp
let mapleader=","
set pastetoggle=<F11>
"-----------------------------------------------------------
" Indentation
filetype plugin on
set expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 
autocmd FileType python setlocal shiftwidth=4 tabstop=4 
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 
autocmd FileType html.handlebars setlocal shiftwidth=2 tabstop=2 
autocmd FileType exs setlocal shiftwidth=2 tabstop=2 
 
"-----------------------------------------------------------
" Syntax highlighting

au BufReadPost *.hbs set syntax=mustache

"-----------------------------------------------------------
" Strip spaces on write
autocmd BufWritePre *.js,*.rb,*.py :%s/\s\+$//e

" Enable syntax highlighting
syntax on

" Colorscheme
colorscheme desert

" Allow for switching between buffers without saving
set hidden
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the

" mapping of <C-L> below)
set hlsearch
nnoremap <F3> :noh<CR>
nmap <silent> ,/ :nohlsearch<CR>
 

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
"------------------------------------------------------------
" Word wrap

:set wrap
:set linebreak
:set nolist  " list disables linebreak

"------------------------------------------------------------
" Special key mappings
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap n ;
nnoremap <Up> 5k
nnoremap <Down> 5j
nnoremap <leader>p :CtrlP<CR>

"------------------------------------------------------------
" Split navigation
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"------------------------------------------------------------
" Pathogen

execute pathogen#infect()

"------------------------------------------------------------
" NerdTree
set modifiable
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 30
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.jshint$']
"------------------------------------------------------------
" Airline

let g:airline_theme="luna"
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"------------------------------------------------------------
" CtrlP

set wildignore+=*/node_modules/*,*/assets/*,*/tmp/*,*.so,*.swp,*.zip,*.svg,*.jpg,*.png,*.pyc,*.jshint,*jscs,*/vendor/*

"------------------------------------------------------------
" Bclose
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

let g:mustache_operators = 1

"------------------------------------------------------------
" flake8 

autocmd FileType python map <buffer> <C-f> :call Flake8()<CR>
let g:flake8_show_in_file = 1
let g:flake8_cmd="/usr/local/bin/flake8"


"------------------------------------------------------------
" rubocop 

let g:vimrubocop_config = '/Volumes/fresh/masterlock/.rubocop.yml'
let g:vimrubocop_keymap = 0
autocmd FileType ruby  map <buffer> <C-f> :RuboCop<CR>

"------------------------------------------------------------
" Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
