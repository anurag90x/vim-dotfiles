set nocompatible
set swapfile
set dir=~/tmp
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
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the

" mapping of <C-L> below)
set hlsearch
nnoremap <F3> :noh<CR>
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
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
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
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
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
 
"------------------------------------------------------------

"------------------------------------------------------------
" Word wrap

:set wrap
:set linebreak
:set nolist  " list disables linebreak

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
map <C-n> :NERDTreeToggle<CR>
set modifiable
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

autocmd FileType ruby  map <buffer> <C-f> :call RuboCop()<CR>
let g:vimrubocop_config = '/Volumes/fresh/masterlock/.rubocop.yml'
