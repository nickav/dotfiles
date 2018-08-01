" Install package manager
let plug_vim=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_vim)
  echo "Installing Plug..."
  echo ""
  silent !mkdir -p ~/.vim/autoload/
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" ------------------------------
" Plugins
call plug#begin('~/.vim/plugged')

" file navigation
Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

" editing
" automatic closing of quotes, parenthesis, brackets
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"
" parentheses, brackets, quotes, XML tags
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" html
Plug 'mattn/emmet-vim'
Plug 'docunext/closetag.vim'
let b:closetag_html_style=0
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
" Shortcut to edit inside HTML tags
autocmd FileType html,eruby,javascript,javascript.jsx nmap ci< cit
autocmd FileType html,eruby,javascript,javascript.jsx nmap ci> cit
autocmd FileType html,eruby,javascript,javascript.jsx nmap di< dit
autocmd FileType html,eruby,javascript,javascript.jsx nmap di> dit

" auto completions
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
Plug 'vim-scripts/AutoComplPop'
let g:acp_behaviorKeywordIgnores = ["end", "if", "do", "while", "else", "elseif", "true", "false", "break", "continue"]

" ctrlp fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_max_files=800
nnoremap <silent> <C-O> :ClearCtrlPCache<cr>\|:CtrlP<cr>

" ack / grep project search
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap \ :Ack!<SPACE>
cnoreabbrev Ack Ack!
nnoremap \* :Ack! <cword><CR>

" linting
Plug 'w0rp/ale'
let g:ale_enabled = 0
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_linter_aliases = {'javascript.jsx': 'javascript', 'jsx': 'javascript'}
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_echo_msg_format = '%linter%: %s'

" rename current file
Plug 'danro/rename.vim'

" comments
Plug 'scrooloose/nerdcommenter'
imap <C-_> <C-o><space>ci
nmap <C-_> <space>ci

" git
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'airblade/vim-gitgutter'

" colorscheme
Plug 'tomasr/molokai'

" code formatting
Plug 'sbdchd/neoformat'
nmap <S-F> :Neoformat<CR>

" javascript
Plug 'pangloss/vim-javascript' , { 'tag': '1.2.5.1' }
let g:javascript_plugin_flow = 1
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
autocmd FileType javascript,javascript.jsx,json,scss,css nmap <S-F> :Neoformat prettier<CR>
" typescript
autocmd BufRead,BufNewFile *.ts setlocal filetype=javascript

" opengl
Plug 'tikhomirov/vim-glsl'
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" macvim-specific plugins
if version >= 800
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsSnippetsDir="~/.vim/ultisnips"
  let g:UltiSnipsSnippetDirectories=["ultisnips"]
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
end

" Initialize plugin system
call plug#end()
" ------------------------------

" Include local config:
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
end

" Inlcude project-specific config (secure means with limiited subset of commmands):
set exrc
set secure

" ------------------------------
" Whitespace

" indentation
set autoindent
set smartindent
" use spaces:
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" use tabs for the following files:
autocmd FileType c,cpp
  \ setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
" commands to quickly set tabbing:
cmap t2 set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
cmap t4 set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" max line width:
set textwidth=80 colorcolumn=80
autocmd FileType h,cpp set textwidth=100 colorcolumn=100
" error on lines longer than 80 characters
highlight ColorColumn ctermbg=gray

" highlight trailing whitespace
autocmd BufReadPost * match Error /\s\+$/
autocmd InsertEnter * match Error /\s\+\%#\@<!$/
autocmd InsertLeave * match Error /\s\+$/
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<CR>

" ------------------------------
" Editor

" make backspace key work
set bs=indent,eol,start

" always show a minimum number of lines (scroll if needed)
set scrolloff=10

" line numbers
if version >= 703
  " default to relative line numbers
  set rnu
  let g:netrw_bufsettings = "set rnu"
else
  " fallback to normal line numbers
  set nu
endif

" better searching
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

" backups
set nohidden
set backupdir=~/.vim/.backup/

" history
set history=1000
set undolevels=1000

" window
set title
set visualbell " don't beep
set noerrorbells

" enable syntax highlighting
syntax on
" colorscheme
set background=dark
colorscheme molokai
autocmd BufEnter * colorscheme molokai
" more colors in terminals
let &t_Co=256
if &term =~ '256color'
  set t_ut=
endif
" use faster, older regex engine
if has('re')
  set re=1
endif

" set leader key
let mapleader = " "

" status bar
set laststatus=2
" show current line number (and file percentage)
set ruler

" variable names
" none of these characters should be word dividers
set iskeyword+=_,$,@

" work in crontab
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" auto reload files if modified outside of vim (git, etc)
set autoread

" wildmenu command mode tab completion
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o,*.pyc,*.class
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.tmp,*.lock
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"


" ------------------------------
" GUI editor
if has("gui_macvim")
  "macvim disable scrollbars
  set guioptions=

  "set default font size on larger screens
  if winheight(0) > 60
    set guifont=Menlo\ Regular:h14
  else
    set guifont=Menlo\ Regular:h12
  endif

  " Press Ctrl-Tab to switch between open tabs (like browser tabs) to
  " the right side. Ctrl-Shift-Tab goes the other way.
  noremap <C-Tab> :tabnext<CR>
  noremap <C-S-Tab> :tabprev<CR>
  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  " goes to the last tab
  noremap <D-9> :tablast<CR>
endif


" ------------------------------
" Keybindings

" duplicate line:
imap <C-d> <esc>:t.<CR>i

" toggle paste mode on/off:
set pastetoggle=<F7>

" saving:
nmap <silent> <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>i
nmap <silent> <leader>q <esc>:q!<CR>

" semi-colon acts as colon
nmap ; :

" exit insert/command mode:
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
cmap <C-k> <up>
cmap <C-j> <down>

" window splitting:
" new window splits go right
set splitright
" use \ and - as vertical and horizontal splits
nmap <C-w>\ <C-w>v
nmap <C-w>- <C-w>s
" control h and l to switch between windows
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <left> <C-w>h
noremap <right> <C-w>l

" scroll viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" tab shift-tab to go back/forth in buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Disable auto-commenting on enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" auto close preview window
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap ; <esc>:pclose<CR>i<right>;

" highlight current cursorline (only enable for one buffer at a time)
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" shortcuts for vimrc
command! Vimrc e ~/.vimrc
command! Reload so $MYVIMRC

" ------------------------------
" Commands

" build/run command
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

" file-specific build commands:
autocmd FileType java let b:run="!javac % | java -cp . %:r"
autocmd FileType javascript let b:run="!node %"
autocmd FileType vim let b:run="so %"
autocmd FileType rust let b:run="!cargo run"

" http://vim.wikia.com/wiki/When_jumping_on_a_tag,_automatically_split_the_window_if_the_current_buffer_has_been_modified
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

" get link to current file in github
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

" Easily switch between h and cpp files
function! ToggleSourceHeader()
	if (expand ("%:e") == "cpp")
		call feedkeys(":e %<.h\<CR>")
	else
		"filereadable(
		call feedkeys(":e %<.cpp\<CR>")
	endif
endfunction

autocmd FileType h,cpp nnoremap <leader>] :call ToggleSourceHeader()<CR>
autocmd FileType h,cpp nnoremap <leader>[ :call ToggleSourceHeader()<CR>

" Automatic C / C++ header guards
function! s:insert_gates()
  let gatename = "__" . substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  normal! o
  execute "normal! Go#endif /* " . gatename . " */"
  normal! k
endfunction
autocmd! BufNewFile *.{h,hpp} call <SID>insert_gates()

" Automatic header file inclusion (foo.c includes foo.h)
function! s:insert_header_incl()
  let filename = expand("%:t")
  execute "normal! i#include " . "\"" . substitute(filename, "\\.c", "\\.h", "g") . "\""
  normal! o
endfunction
autocmd! BufNewFile *.{c,cpp} call <SID>insert_header_incl()

" aliases
function! CommandCabbr(abbreviation, expansion)
  execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
" Use it on itself to define a simpler abbreviation for itself.
CommandCabbr ccab CommandCabbr
CommandCabbr ag Ack!
CommandCabbr eh e<space>~
CommandCabbr ep e<space>~/dev

" ------------------------------
" Terminal Emulation

" system pasting in terminal:
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

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
