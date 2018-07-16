" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible


" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
syntax enable

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
set t_Co=16
set backspace=indent,eol,start

"Set encoding 
set encoding=utf-8
set shiftwidth=4
set softtabstop=4


" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

set expandtab

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

execute pathogen#infect()
execute pathogen#helptags()


"Map leader
let mapleader=","

colorscheme solarized 

map <C-n> :NERDTreeToggle<CR>
nmap <C-x> :SlimeSend
set nu
set wrap
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Automatic folding
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

:hi Folded ctermfg=2
let g:syntastic_python_checkers=["pyflakes"]

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=0
let g:syntastic_loc_list_height=10
let g:syntastic_mode_map = {
	\ "mode": "passive",
	\}

let g:pymode_lint_on_write=0
let g:pymode_doc=1
let g:pymode_doc_bind='K'
let g:pymode_rope=0
let g:pymode_indent=1
let g:pymode_options_colorcolumn=0


"Tmux stuff
let g:slime_target = "tmux"
let g:slime_python_ipython=1

"Commenting
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"Omnifunc
set omnifunc=syntaxcomplete#Complete

"R stuff
let R_in_buffer=0
let R_applescript=0
let R_tmux_split=1
let R_assign=2


au BufRead,BufNewFile,BufReadPost *.json colorscheme slate 
