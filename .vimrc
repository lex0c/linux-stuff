set ttymouse=xterm2
set number
"set relativenumber
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
set title

syntax on

filetype on

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
" nnoremap <leader>a ggVG

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
  au FileType python set shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
  au FileType go set shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
  autocmd BufNewFile,BufRead *.ts set filetype=javascript
  autocmd BufNewFile,BufRead *.vue set filetype=javascript
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.py set filetype=python
  autocmd BufNewFile,BufRead *.go set filetype=go
  " Red coloring at whitespace after end of line whitespace
  autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
  autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
  highlight EOLWS ctermbg=red guibg=red
endif

