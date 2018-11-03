" __     ___           
" \ \   / (_)_ __ ___  
"  \ \ / /| | '_ ` _ \ 
"   \ V / | | | | | | |
"    \_/  |_|_| |_| |_|

set encoding=utf-8
scriptencoding utf-8
                    
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/splitjoin.vim'
Plug 'bkad/camelcasemotion'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim'
Plug 'konfekt/fastfold'
" Plug 'ludovicchabant/vim-gutentags' -- not async and makes vim really slow
" Plug 'mhinz/vim-startify'
" Plug 'roman/golden-ratio'
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'
Plug 'wellle/targets.vim'

Plug 'lervag/vimtex', {'for': 'latex'}
Plug 'vim-pandoc/vim-pandoc', {'for': ['latex', 'pandoc', 'markdown']}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['latex', 'pandoc', 'markdown']}

Plug 'chriskempson/base16-vim'
Plug 'romainl/apprentice'

if(has('nvim'))
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()
filetype plugin indent on
syntax on

set mouse=nvi

set guifont=PragmataPro:h12

colorscheme base16-eighties
set background=dark
set fileformat=unix
set hlsearch incsearch ignorecase smartcase
set listchars=eol:↲,tab:▶▹,nbsp:␣,extends:…,trail:•
set matchpairs+=<:>
set nowrap
set number relativenumber
set textwidth=80

set splitright splitbelow

set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set expandtab

set foldmethod=syntax
let g:tex_fold_enabled=1
let g:vimsyn_folding=1
let g:xml_syntax_folding=1
let g:php_folding=1
let g:perl_folding=1


"""""""""""
"FUNCTIONS"
"""""""""""
function! Reg()
  reg
  echo 'Register: '
  let char = nr2char(getchar())
  if char !=? "\<Esc>"
    execute 'normal! "' . char . 'p'
  endif
  redraw
endfunction
command! -nargs=0 Reg call Reg()
nnoremap gs :Reg<cr>

"Cleans written buffers
function! s:wipeout()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  let wiped = 0
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && !getbufvar(v:val,"&mod")')
    silent execute 'bwipeout!' buf
    let wiped += 1
  endfor
  echom wiped . ' buffers wiped'
endfunction
command! Wipeout call s:wipeout()

let mapleader=','
let g:mapleader=','

"insert mode
"===========
"make shit easier to escape
inoremap <silent> jk <ESC>
cnoremap <silent> jk <C-c>

"remove the highlighting after
nnoremap <silent> i :nohl<cr>i
"set current directory to file location
nnoremap <silent> <leader>cd :cd %:p:h<CR>

"make the n and N center the line
nmap <silent> n :norm! nzzzv<CR>
nmap <silent> N :norm! Nzzzv<CR>

" make a new Ex-mode opener
nnoremap <space> :
vnoremap <space> :

"YankRing
nmap "" :Reg<CR>

noremap <expr> j v:count > 1 ? 'm`' . v:count . 'j' : 'gj'
noremap <expr> k v:count > 1 ? 'm`' . v:count . 'k' : 'gk'

"Go to last copy
nmap gV `[v`]

nnoremap dD 0d$


"Ex mode
cmap w!! %!sudo tee > /dev/null %

"Visual block moving
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"remap so it does macros over every line
vnoremap @ :norm@

"highlight
nmap <leader><space> :nohl<CR>

"misc
map Y y$

" map the system clipboard to leader  
nnoremap <leader>y "+y
vnoremap <leader>y "+y

nnoremap <leader>Y "+Y
vnoremap <leader>Y "+Y

nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap <leader>P "+P
vnoremap <leader>P "+P

nnoremap <silent> <leader>f :Files<CR>
" 

set nrformats -=octal "removes silly octal 
                      "<C-A> options so 
                      "increments with leading 0
set magic

"WILD MENU 
set wildmenu                                     | " enable wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    | " Version control
set wildignore+=*.aux,*.out,*.toc                | " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   | " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest | " compiled object files
set wildignore+=*.spl                            | " compiled spelling word lists
set wildignore+=*.sw?                            | " Vim swap files
set wildignore+=*.DS_Store                       | " OSX crap
set wildignore+=*.luac                           | " Lua byte code
set wildignore+=migrations                       | " Django migrations
set wildignore+=*.pyc                            | " Python byte code
set wildignore+=*.orig                           | " Merge resolution files
set wildignore+=*/node_modules/*                 | " Remove the node modules


"SEARCH MENU 


let g:ale_javascript_eslint_suppress_eslintignore = 1

call camelcasemotion#CreateMotionMappings('<leader>')
set omnifunc=syntaxcomplete#Complete


set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
let g:polyglot_disabled = ['latex']

set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

set undodir=~/.vim/undo/
set undofile

set lazyredraw
set shortmess=aIT


set statusline=\ %f           " Path to the file
set statusline+=\ %m          " Modified flag
set statusline+=\ %y          " Filetype
set statusline+=%=            " Switch to the right side
set statusline+=%l            " current line
set statusline+=/%L           " Total lines
set statusline+=\ -\ %{statusline#linter()}\ 
