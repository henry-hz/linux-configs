set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()


"------------------------------------------------------------------------------
"" Vundle
"------------------------------------------------------------------------------
"
"" Vundle manages vundle
Bundle 'gmarik/vundle'
" Programming-specific plugins
" Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/zencoding-vim'
" Bundle 'kchmck/vim-coffee-script'
Bundle 'digitaltoad/vim-jade'
" Bundle 'nono/vim-handlebars'
" Bundle 'tpope/vim-fireplace'
" Bundle 'guns/vim-clojure-static'
" " Easier editing plugins
" Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdcommenter'
" Bundle 'tpope/vim-surround'
" Bundle 'godlygeek/tabular'
" " UX plugins
Bundle 'altercation/vim-colors-solarized'
Bundle 'msutherl/vim-colors-ir_black-256'
Bundle 'chriskempson/base16-vim'
Bundle 'noahfrederick/Hemisu'
Bundle 'euclio/vim-nocturne'
Bundle 'vim-scripts/CSApprox'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'spolu/dwm.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" " Movement plugins
Bundle 'paradigm/vim-multicursor'
Bundle 'Lokaltog/vim-easymotion'
" Bundle 'sjl/gundo.vim'
" " Auto-complete and snippet plugins
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
" Bundle 'vim-scripts/SearchComplete'
" " File navigation and opening plugins
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/sudo.vim'
Bundle 'jimenezrick/vimerl'
"------------------------------------------------------------------------------
" Standard config
"------------------------------------------------------------------------------
" Looks
set ttyfast    " indicates we have a strong
               " terminal connection
set ttimeoutlen=50
syntax enable
colorscheme ninja
" Override colorscheme bg so they look properly under any decent terminal -
" it's more of a hack than anything else
highlight Normal ctermbg=NONE
set cursorline
set cursorcolumn
" Show trailing spaces
set listchars=trail:.
set list

" Look good on linux:
if has("unix")
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname == "Linux"
    set t_Co=256
    if $TERM =~ '256color'
      " Disable Background Color Erase (BCE) so that color schemes work
      " properly when Vim is used inside tmux and GNU screen.  See also
      " http://snk.tuxfamily.org/log/vim-256color-bce.html
      set t_ut=
    endif
  endif
endif

" Make vim relativenumbers
set relativenumber
" Indentation, textwidth and colorcolumn
set autoindent smartindent
set textwidth=79
set colorcolumn=79
" Set tabs as 4 spaces - type :retab for setting a
" file's tabs to spaces
set expandtab
set shiftwidth=4
set tabstop=4
" Better overall tab key behaviour
set smarttab
" General
set hidden                   " edit multiple unsaved files at the
                             " same time
set ic                       " ignorecase in search
set complete=.,w,b,u,U,t,i,d
set completeopt-=preview
set clipboard=unnamed        " yank and paste with the system clipboard
set noerrorbells
set wildmenu                 " better shell command managing
set pastetoggle=<F2>
set encoding=utf-8
set hlsearch                 " Highlight searches
set incsearch                " Highlight searches as they're typed
set autochdir                " Change working directory to
                             " whichever file is open or selected
set noesckeys
" I personally prefer this. But when it's
" convenient you can always change it with
" :set wrap
set nowrap
set nocompatible
filetype plugin on


"------------------------------------------------------------------------------
" Mappings
"------------------------------------------------------------------------------
let mapleader = ","

" Easily move lines around:
nnoremap [e dd\|k\|P
nnoremap ]e dd\|p

" Turn paste mode on or off
nnoremap <silent> [p :set paste<cr>
nnoremap <silent> ]p :set nopaste<cr>

" Toggle rainbow parentheses
nnoremap <silent> <leader>p :RainbowParenthesesToggle<cr>

" Quickly edit .vimrc:
nnoremap <leader>ev :vs $MYVIMRC<cr>

" Repeat last substitution
nnoremap <leader>r :s<cr>

" Resize to textwidth
nnoremap <silent> <leader>tw :call TextWidthResize()<CR>

func! TextWidthResize()
  exec "vertical resize ".(&textwidth+4) 
  " The +4 is simply to account for the line numbers - solving this problem
  " better is a TODO
endfunc

" File type useful coding stuff:
augroup fileTypeMods
  autocmd!
  " Jade
  autocmd FileType jade set shiftwidth=2
  " Html
  autocmd FileType html set shiftwidth=2
  " Javascript
  autocmd FileType javascript set shiftwidth=2
  " CSS
  autocmd FileType css set shiftwidth=2
  " Python
  autocmd FileType python nnoremap <buffer> <leader>c I# <esc>j0
  autocmd FileType python nnoremap <buffer> <leader>mk :call InterpretPython()<CR>
  autocmd FileType python nnoremap <buffer> <leader>nk :w<CR>:!python %
  autocmd FileType python colorscheme molokai
  " C
  autocmd FileType c nnoremap <buffer> <leader>mk :call CompileRunGcc()<CR>
  " English Spell Checking
  autocmd FileType text set spell
  autocmd FileType text set spelllang=en
augroup END

" Compile or interpret
func! CompileRunGcc()
  exec "w"
  exec "!gcc --std=c99 -Wall % -o %<.out; ./%<.out"
endfunc
func! InterpretPython()
  exec "w"
  exec "!python %"
endfunc

" Tabs
nnoremap tt :tabnew<CR>
nnoremap tn :tabnext<CR>
nnoremap te :tabedit
nnoremap tc :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprevious<CR>

" Tabularize
vnoremap <leader>w :Tabularize/

" Toggle NERDTree
nnoremap <leader>n :NERDTreeTabsToggle<CR>

" Clear search
nnoremap <silent><Leader>/ :nohlsearch<CR>

" Make H and L go to the beggining and end of a
" line, respectively.
noremap H ^
noremap L $

" Open ctags definition in a new tab
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open ctags definition in a vertical split - instead of a horizontal one
noremap <C-W><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" General tweaks:
onoremap p i(


"------------------------------------------------------------------------------
" ZenCoding
"------------------------------------------------------------------------------
let g:user_zen_leader_key = '<c-k>'

"------------------------------------------------------------------------------
" Rainbow Parentheses
"------------------------------------------------------------------------------
au Vimenter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces



"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['ruby', 'php', 'python', 'c', 'cpp'],
                               \ 'passive_filetypes': ['html', 'puppet', 'erl', 'erlang'] }


"------------------------------------------------------------------------------
" Status Line - except for the first line, this is
" ignored by PowerLine.
"------------------------------------------------------------------------------
set laststatus=2
set statusline=%f             " Path to the file
set statusline+=%=            " Switch to the right side
set statusline+=%#warningmsg# " Syntastic stuff(next 3 lines)
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%l            " Current line
set statusline+=/             " Separator
set statusline+=%L            " Total lines


"------------------------------------------------------------------------------
" PowerLine
"------------------------------------------------------------------------------
let g:Powerline_symbols='compatible'
let g:Powerline_colorscheme='solarized256'
let g:Powerline_stl_path_style='full'


 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
 "
set backspace+=start,eol,indent
set nolist
