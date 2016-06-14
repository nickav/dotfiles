set nocompatible  " be iMproved
filetype off      " required!

let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle - required!
Bundle 'gmarik/vundle'
" Bundles
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/emmet-vim'
Bundle 'Raimondi/delimitMate'
"Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
" Auto Completions:
" light:
Bundle 'vim-scripts/AutoComplPop'
Bundle 'Rip-Rip/clang_complete'
" heavy:
"Bundle 'Valloric/YouCompleteMe'
" :End Auto Completions
Bundle 'docunext/closetag.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'xolox/vim-session'
Bundle 'tpope/vim-repeat'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-misc'
"Bundle 'c9s/bufexplorer'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'scrooloose/nerdtree'
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-scripts/dbext.vim'
Bundle 'vim-ruby/vim-ruby'
"Bundle 'spf13/PIV'
"Bundle 'godlygeek/tabular'
"Bundle 'L9'
" Color Schemes
Bundle 'tomasr/molokai'
Bundle 'vim-scripts/SyntaxRange'
Bundle 'danro/rename.vim'

" Include local config:
source ~/.vimrc.local

filetype plugin indent on " required!

set bs=indent,eol,start
set smartcase
set scrolloff=4 " show at least _ lines
set ts=4 " tab width
set shiftwidth=4
set softtabstop=4
"set expandtab " use spaces instead
set smartindent
set autoindent
set ruler
if version >= 703
	set rnu " relative line numbers
endif

" dont' wrap text
"set textwidth=0
"set wrapmargin=0

set showmatch
set incsearch
set hlsearch
set ignorecase

set nohidden
"set nobackup
"set nowritebackup
"set noswapfile
set backupdir=~/.tmp

set history=1000
set undolevels=1000
set title
set visualbell " don't beep
set noerrorbells

set term=ansi
syntax on
let mapleader = " "
set laststatus=2 " show status bar

" none of these should be word dividers
set iskeyword+=_,$,@,%,#

" new window splits go right
set splitright

" crontab
if $VIM_CRONTAB == "true"
set nobackup
set nowritebackup
endif

" vim auto reload with git
set autoread

" keybindings
" recognize function keys:
execute "set <F1>=\eOP"
execute "set <F2>=\eOQ"
execute "set <F3>=\eOR"
execute "set <F4>=\eOS"
execute "set <F5>=\e[15;*~"
execute "set <F6>=\e[17;*~"
execute "set <F7>=\e[18;*~"
execute "set <F8>=\e[19;*~"
execute "set <F9>=\e[20;*~"
execute "set <F10>=\e[21;*~"
execute "set <F11>=\e[23;*~"
execute "set <F12>=\e[24;*~"
" duplicate line:
imap <C-d> <esc>:t.<CR>i
" copy, cut, pase:
vmap <C-c> y
vmap <C-x> x
imap <C-v> <esc>P
set pastetoggle=<F7>
" Paste from clipboard
imap <D-V> ^O"+p
" saving:
nmap <silent> <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>
nmap <silent> <leader>s <esc>:wq<CR>
nmap <silent> <leader>q <esc>:q!<CR>
" semi-colon
nmap ; :
inoremap jj <esc>
cnoremap jj <esc>
inoremap jk <esc>
cnoremap jk <esc>
"inoremap dw <c-o>dw
" tabs:
nnoremap <silent> tt :tabnew<CR>
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
nnoremap <silent> tq :tabclose<CR>
"nmap <silent> <S-Tab> :tabprevious<CR>
"nmap <silent> <Tab> :tabnext<CR>
" function keys: TODO fix laststatus
nnoremap <silent> <F1> :set nu<CR>
nnoremap <silent> <F2> :set nornu!<CR>
" reload current file
noremap <F5> <esc>:so %<CR>
function! ToggleFocusMode()
  if (&laststatus != 0)
    set laststatus=0
    set noruler
	set nornu
  else
    set laststatus=2
    set ruler
	set rnu
  endif
endfunc
nnoremap <silent> <F3> :call ToggleFocusMode()<cr>

"au BufWritePost .vimrc so $VIMRC
" clear search:
"nmap <silent> <leader>/ :nohlsearch<CR>
nnoremap <silent> <CR> :nohlsearch<CR>
" forgot to sudo? really write the file
cmap w!! w !sudo tee % >/dev/null
" jump to closing brace
nmap }} <esc>]}i<right>
" disable arrow keys:
"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-h> <left>
inoremap <C-l> <right>
" window navigation:
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
imap <C-w> <C-o><C-w>
nmap - <C-W>5-
nmap + <C-W>5+
nmap = <C-w>=
nmap <C-W>> <C-W>5<
nmap <C-W>< <C-W>5>
"nmap <C-w>v <C-w>v:e<space>
nmap <C-w><C-v> <C-w>v
nmap <C-w>\ <C-w>v
nmap <C-w><C-\> <C-w>v
nmap <C-w>- <C-w>s
nmap <silent> <C-w>N :vnew<CR>
" Make C-w C-L resize and C-w > swap
"nnoremap <C-w>L <C-w>>
" scroll viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
" Open def in new tab, open def in vs:
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" Increment Number (re-map)
nmap <C-z> <C-a>
" Disable auto-commenting on enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" highlight bad whitespace
autocmd BufReadPost * match BadWhitespace /\s\+$/
autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=1
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" auto close preview window
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap ; <esc>:pclose<CR>i<right>;

" toggle relative / absolute line numbers
au InsertEnter * set nu
au InsertLeave * set rnu

" highlight current cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Build commands 
function! Build() "a:command
	let cmd = &filetype
	if (cmd == 'javascript')
		let cmd = 'node'
	endif
	execute "w"
	execute "!" . cmd . " " . expand("%")
endfunction
nmap <leader>l :call Build()<CR>
nmap <leader><CR> :call Build()<CR>
"nmap <S-B> 

fun! JavaSetup()
	nmap <leader>l :call JavaC()<CR>
	nmap <leader><CR> :call JavaC()<CR>
endfunction

function! JavaC()
	execute "w"
	execute "!javac" . " " . expand("%")
	execute "!java " . "-cp . " . expand("%:r") 
endfunction
autocmd FileType java call JavaSetup()

" Split Tags
fun! SPLITAG() range
  let oldfile=expand("%:p")
  if &modified
    split
  endif
  exe "tag ". expand("<cword>")
  let curfile=expand("%:p")
  if curfile == oldfile
    let pos=getpos(".")
    if &modified
      " if we have split before:
      quit
    endif
    call setpos('.', pos)
  endif
endfun
nmap <C-]> :call SPLITAG()<CR>z.

" HTML Emment Tab binding
function! Smart_HTMLTab()
  let line = getline('.')
  let substr = strpart(line, -1, col('.'))
  let substr = matchstr(substr, "[^ \t]*$")
  let has_slash = match(line, '\/') != -1
  if (strlen(substr)==0)
    call feedkeys("\<C-t>")
  elseif (has_slash)	
    call feedkeys("\<C-y>n")
  else
    call feedkeys("\<C-y>,")
  endif
endfunction

function! Expand_Enter()
	let line = getline('.')
	let col = col('.')
	let first = line[col-2]
	let second = line[col-1]
	let third = line[col]
	if (first ==# ">" && second ==# "<" && third ==# "/")
		return "\<CR>\<C-o>==\<C-o>O"
	else
		return "\<CR>"
	endif
endfunction

function! Setup_HTML()
	inoremap <buffer> <tab> <C-o>:call Smart_HTMLTab()<CR>
	inoremap <buffer> <S-tab> <C-y>N
	inoremap <buffer> <expr> <Enter> Expand_Enter()
endfunction

autocmd FileType html,xml inoremap <buffer> <tab> <C-o>:call Smart_HTMLTab()<CR>
" added php
autocmd FileType html,xml,php,eruby call Setup_HTML()

"Easily switch between h and cpp files
function! ToggleSourceHeader()
	if (expand ("%:e") == "cpp")
		call feedkeys(":e %<.h\<CR>")
	else
		"filereadable(
		call feedkeys(":e %<.cpp\<CR>")
	endif
endfunction

autocmd FileType h,cpp nnoremap <tab> <C-o>:call ToggleSourceHeader()<CR>
nnoremap <C-f> <C-o>:CtrlPBuffer<CR>

au BufReadPost *.lzz set syntax=cpp 

function! RunApp()
	call RunBuildCommand("xcodebuild -target Ball -arch x86_64 -configuration Debug")
endfunction

function! RunBuildCommand(cmd)
	echo "Building..."
	exec "silent !" . a:cmd . " >build/vim.log 2>&1"

	silent !grep -q '^\*\* BUILD FAILED' build/vim.log
	redraw!
	if !v:shell_error
		set errorformat=
			\%f:%l:%c:{%*[^}]}:\ error:\ %m,
			\%f:%l:%c:{%*[^}]}:\ fatal error:\ %m,
			\%f:%l:%c:{%*[^}]}:\ warning:\ %m,
			\%f:%l:%c:\ error:\ %m,
			\%f:%l:%c:\ fatal\ error:\ %m,
			\%f:%l:%c:\ warning:\ %m,
			\%f:%l:\ error:\ %m,
			\%f:%l:\ fatal\ error:\ %m,
			\%f:%l:\ warning:\ %m
		cfile! build/vim.log
	else
		echo "Building... OK!"
	endif
endfunction

" use 2 spaces instead of tabs for the following files
autocmd FileType ruby,eruby,html,yaml,css,scss,javascript,coffee setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2
au BufRead,BufNewFile *.tag,*.vue set ft=html

command CC CoffeeCompile

" auto open index.js and template.html split screen (when index is opened)
autocmd FileType javascript call VueJS_Split()

function! VueJS_Split()
	if (expand('%:t') == 'index.js')
		let dir = expand('%:p:h')
		let temp = dir . '/template.html'
		if (filereadable(temp))
			execute "lefta vsp " . temp
			execute "set ft=html"
		endif
	endif
endfunction

" wildmenu
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp,*.lock
set wildmenu
set wildmode=longest,list

" console bindings
cmap <C-k> <up>
cmap <C-j> <down>

" color scheme setup
let &t_Co=256
set t_ut=
colorscheme molokai
let g:solarized_termcolors = 256

" marks
noremap <leader>m <Esc>:marks<CR>
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" packages setup
" multi cursors:
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Easy Motion - f, t, w:
let g:EasyMotion_leader_key = '<Leader>'
" Super tab:
"let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" delimitMate:
"autocmd FileType vim let g:delimitMate_autoclose = 0
"autocmd FileType php,c,cpp,objc,h,m,java,javascript let g:delimitMate_autoclose = 1
let g:delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"
" Close Tags - only load for html files:
let b:closetag_html_style=0
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
" Ctrl-P
nnoremap <leader>. :CtrlPTag<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
" Sessions
let g:session_autoload = 'yes'
let g:session_autosave = 'no'
let g:session_default_to_last = 'yes'
" Nerdcommenter (leader)
imap <C-_> <C-o><space>ci
nmap <C-_> <space>ci

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files=800
" AutoComplPop
let g:acp_behaviorKeywordIgnores = ["end", "if", "do", "while", "else", "elseif", "true", "false", "break", "continue"]
