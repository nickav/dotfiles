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
Plugin 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"

Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" auto completions:
Plugin 'vim-scripts/AutoComplPop'
let g:acp_behaviorKeywordIgnores = ["end", "if", "do", "while", "else", "elseif", "true", "false", "break", "continue"]
"Plugin 'Rip-Rip/clang_complete'

Plugin 'docunext/closetag.vim'
" only load for html files:
let b:closetag_html_style=0
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1

if executable('fzf')
  Plugin 'junegunn/fzf'
  Plugin 'junegunn/fzf.vim'
  nmap <C-p> :FZF<CR>
else
  " fallback to CtrlP
  Plugin 'kien/ctrlp.vim'
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_max_files=800
endif

Plugin 'vim-airline/vim-airline'
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

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/dbext.vim'
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-eunuch'
Plugin 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<space><C-r><C-w><CR>
  cnoreabbrev ag Ag
endif

" Include local config:
source ~/.vimrc.local

filetype plugin indent on " required!

set bs=indent,eol,start
set smartcase
set scrolloff=4 " show at least _ lines
set smartindent
set autoindent
set ruler

" use faster, older regex engine
if has('re')
  set re=1
endif

" whitespace
" use spaces:
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" use tabs for the following files:
autocmd FileType c,cpp
  \ setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
" max line width:
set textwidth=80
" error on lines longer than 80 characters
autocmd BufEnter,BufReadPost,InsertLeave * match Error /\%81v.\+/

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
set iskeyword+=_,$,@,%,#,-

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
set wildignore+=*.a,*.o,*.pyc,*.class
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.tmp,*.lock
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildmenu
set wildmode=longest,list

" color scheme setup
let &t_Co=256
set t_ut=
set background=dark
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

" replace all occurences of current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" clear search:
nnoremap <silent> <CR> :nohlsearch<CR>
" forgot to sudo? really write the file
cmap w!! w !sudo tee % >/dev/null

" control-hjkl as navigation
noremap <C-k> <up>
noremap <C-j> <down>
noremap <C-h> <left>
noremap <C-l> <right>
imap <C-k> <up>
imap <C-j> <down>
imap <C-h> <left>
imap <C-l> <right>

" console navigation
cmap <C-k> <up>
cmap <C-j> <down>
" window splitting:
nmap <C-w>\ <C-w>v
nmap <C-w>- <C-w>s
" scroll viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
" Open def in new tab, open def in vs:
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" Shortcut to edit HTML tag
nmap ci< cit
nmap ci> cit

" tab shift-tab to go back/forth in buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Disable auto-commenting on enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" highlight bad whitespace
autocmd BufReadPost * match BadWhitespace /\s\+$/
autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=1

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<CR>

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
  let run = "!" . &filetype . " " . expand("%")
  if exists("b:run")
    let run = b:run
  elseif exists("t:run")
    let run = t:run
  elseif exists("w:run")
    let run = w:run
  elseif exists("g:run")
    let run = g:run
  endif
  " save and run:
  execute "w"
  execute run
endfunction

command! Run :call Run()
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

" understand special filetypes:
au BufRead,BufNewFile *.tag,*.vue set ft=html

function! GithubLink()
  let remote = system("git remote -v | sed -n '1 p' | awk '{print $2}'")
  let remote = substitute(remote, ".git\n", "", "")
  let line = line(".")
  let fname = expand("%@")

  let linestr = "#L" . line
  if line == 1
    let linestr = ''
  endif

  echo remote . "/blob/master/" . fname . linestr
endfunction
command! GithubLink :call GithubLink()
command! Glink :call GithubLink()

let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

autocmd BufEnter,BufRead,BufNewFile * silent! exec '!echo -ne "\033];%\007" && tmux set -g set-titles-string "%"'
