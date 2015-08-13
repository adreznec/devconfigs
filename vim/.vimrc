filetype off
if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

endif

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Pull in all bundles from GitHub
Plugin 'tpope/vim-fugitive'
Plugin 'tomasr/molokai'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/syntastic'
Plugin 'mbbill/undotree'
Plugin 'chase/vim-ansible-yaml'

call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start configuration options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic configuration changes:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on
set encoding=utf-8
" Remove trailing whitespace
autocmd FileType bash,c,cpp,java,php,python,yml autocmd BufWritePre <buffer> :%s/\s\+$//e
set history=700
set autoread
set showcmd
set so=7
set wildmenu
" Show current position
set ruler
" Height of the command bar
set cmdheight=2
" Hide buffer when abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
" Don't redraw when executing macros for performace
set lazyredraw
set magic
" Show matching brackers
set showmatch
"Blink every X tenths of a second when matching brackets
set mat=3
set noerrorbells
set novisualbell
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%
" Show the status line
set laststatus=2
" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" Turn persistent undo on
try
    set undodir=~/.vim
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, syntax, and coloring changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif
set t_Co=256
set background=dark
" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Use spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap
let python_highlight_all=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybind changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" With a map leader it's possible to do extra key combinations
let mapleader = ","
" like <leader>w saves the current file
let g:mapleader = ","
" Fast saving
nmap <leader>w :w!<cr>
" Use Q for formatting
map Q gq
" use :W to sudo save the file
command W w !sudo tee % > /dev/null
" Visual mode pressing * or # searches for selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>
" Useful mappings for managing tabs
map <leader>nt :tabnew<cr>
map <leader>ot :tabonly<cr>
map <leader>ct :tabclose<cr>
map <leader>mt :tabmove
map <leader>t :tabnext
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
nnoremap <F5> :UndotreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" set fillchars+=stl:\ ,stlnc:\
set guifont=Meslo\ LG\ M\ for\ Powerline\ 9

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Flake8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:flake8_builtins="_,apply"
" autocmd BufWritepost *.py call Flake8()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" molokai
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rehash256=1
colorscheme molokai

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
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
