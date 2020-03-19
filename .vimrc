set ttymouse=xterm2
set number
set relativenumber
set linespace=12
set background=dark
set expandtab
set linebreak
set breakindent
set shiftwidth=2
set tabstop=2
set backspace=indent,eol,start
set nocompatible
set hidden
set confirm
set autowriteall
set wildmenu
set showcmd
set hlsearch
set nomodeline
set ignorecase
set smartcase
set autoindent
set nostartofline
set ruler
set laststatus=2
set mouse=
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set colorcolumn=120
set foldmethod=syntax
set guifont=Monospace\ Regular\ 10
set showmatch
set incsearch
set foldenable
set path+=**

syntax enable

filetype indent plugin on

map Y y$
map <C-a> :%y+<Esc>

inoremap jk <esc>

nnoremap <space> za
nnoremap j gj
nnoremap k gk
nnoremap <Up>       <Nop>
nnoremap <Down>     <Nop>
nnoremap <Right>    <Nop>
nnoremap <Left>     <Nop>
nnoremap <C-L> :nohl<CR><C-L>

packloadall

if has("xorg-xmodmap")
  au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
  au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au FileType javascript set shiftwidth=2 softtabstop=2 expandtab foldmethod=indent
  au FileType cs set shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
  au FileType php set shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
  autocmd BufNewFile,BufRead *.ts set filetype=javascript
  autocmd BufNewFile,BufRead *.vue set filetype=javascript
endif

let g:jsx_ext_required = 1
let g:jsx_pragma_required = 1
let g:indentLine_leadingSpacChar='·'
let g:indentLine_leadingSpaceEnabled='1'
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

