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
Plugin 'gmarik/vundle'

" Plugins
Plugin 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'

Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"

Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" auto completions:
" light:
Plugin 'vim-scripts/AutoComplPop'
let g:acp_behaviorKeywordIgnores = ["end", "if", "do", "while", "else", "elseif", "true", "false", "break", "continue"]
Plugin 'Rip-Rip/clang_complete'
" heavy:
"Plugin 'Valloric/YouCompleteMe'

Plugin 'docunext/closetag.vim'
" only load for html files:
let b:closetag_html_style=0
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1

Plugin 'kien/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files=800
nnoremap <C-f> <C-o>:CtrlPBuffer<CR>

Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-repeat'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'scrooloose/nerdcommenter'
imap <C-_> <C-o><space>ci
nmap <C-_> <space>ci

Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/dbext.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-eunuch'
Plugin 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1

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

set nu
if version >= 703
	set rnu " relative line numbers
endif

set showmatch
set incsearch
set hlsearch
set ignorecase

set nohidden
set backupdir=~/.vim/.backup//

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

" vim project-specific .vimrc files
set exrc
set secure

" wildmenu
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp,*.lock
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
set wildmenu
set wildmode=longest,list

" color scheme setup
let &t_Co=256
set t_ut=
colorscheme molokai
let g:solarized_termcolors = 256

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
" saving:
nmap <silent> <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>i
nmap <silent> <leader>s <esc>:wq<CR>
nmap <silent> <leader>q <esc>:q!<CR>
" semi-colon
nmap ; :
inoremap jk <esc>
cnoremap jk <esc>
" tabs:
nnoremap <silent> tt :tabnew<CR>
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
" reload current file
noremap <F5> <esc>:so %<CR>

" clear search:
nnoremap <silent> <CR> :nohlsearch<CR>
" forgot to sudo? really write the file
cmap w!! w !sudo tee % >/dev/null
" jump to closing brace
nmap }} <esc>]}i<right>
" control-hjkl as navigation
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-h> <left>
inoremap <C-l> <right>
" console navigation
cmap <C-k> <up>
cmap <C-j> <down>
" window navigation:
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
imap <C-w> <C-o><C-w>
" window resizing:
nmap - <C-W>5-
nmap + <C-W>5+
nmap = <C-w>=
nmap <C-W>> <C-W>5<
nmap <C-W>< <C-W>5>
" window splitting:
nmap <C-w><C-v> <C-w>v
nmap <C-w>\ <C-w>v
nmap <C-w><C-\> <C-w>v
nmap <C-w>- <C-w>s
nmap <silent> <C-w>N :vnew<CR>
" scroll viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
" Open def in new tab, open def in vs:
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

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

" highlight current cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Build/run command

function! Run()
	let b:run = get(b:, 'run', "!" . &filetype . " " . expand("%"))
	" save and run:
	execute "w"
	execute b:run
endfunction

command Run :call Run()
nmap <leader>l :Run<CR>
nmap <leader><CR> :Run<CR>

" custom build commands
autocmd FileType java let b:run="!javac % | java -cp . %:r"
autocmd FileType javascript let b:run="!node %"
autocmd FileType vim let b:run="so %"

" When jumping on a tag, automatically split the window if the current buffer has been modified
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

Easily switch between h and cpp files
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

" whitespace:
" use 2 spaces instead of tabs for the following files
autocmd FileType ruby,eruby,html,yaml,css,scss,javascript,coffee setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2

au BufRead,BufNewFile *.tag,*.vue set ft=html
au BufRead,BufNewFile *.md,*.txt set tw=80

" auto open index.js and template.html split screen (when index is opened)
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
autocmd FileType javascript call VueJS_Split()

let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
