" THEMES
" ===============
syntax on
" dark theme
colors gruvbox

" My Plugins
" ===============
call plug#begin('~/.vim/plugged')

Plug 'benmills/vimux'
Plug 'bronson/vim-trailing-whitespace'
Plug 'bswinnerton/vim-test-github'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'groenewege/vim-less'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'koron/nyancat-vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'wojtekmach/vim-rename'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

call plug#end()

" Get that filetype stuff happening
filetype on

let mapleader = ","

" Git Stuff
map <Leader>ga :Git add
map <Leader>gad :Git add .<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gcv :Gcommit --verbose<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gb :Git branch<CR>
map <Leader>gh :Gbrowse<CR>
map <Leader>gbr :Git branch -r<CR>

"Rails
map <Leader>m :Rmodel
map <Leader>vm :RVmodel
map <Leader>sm :RSmodel
map <Leader>c :Rcontroller
map <Leader>vc :RVcontroller
map <Leader>sc :RScontroller
map <Leader>v :Rview
map <Leader>vv :RVview
map <Leader>sv :RSview
map <Leader>ut :Runittest
map <Leader>vut :RVunittest

" Utilities
map <Leader>hs :split
map <Leader>vs :vsplit
map <Leader>a :Ack
map <Leader>fw :FixWhitespace<CR>
map <Leader>tn :tabnew<CR>
map <Leader>tc :tabclose<CR>

" vimconfig
nmap <leader>v :tabedit $MYVIMRC<CR>

"" Quick Theme Change
map <Leader>l :set colorcolumn=80 <CR>

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>
map <Leader>i mmgg=G`m<CR>

" ctags refresh
map <Leader>ct :!ctags -R .<CR>

" fast save and quit
noremap <leader>q :q<cr>
nnoremap <leader>s :w<cr>
" inoremap <leader>s <C-c>:w<cr>

" vimux
let g:VimuxPromptString = ""
map <Leader>op :VimuxRunCommand("")<CR>
map <Leader>cp :VimuxCloseRunner<CR>
map <Leader>vc :VimuxPromptCommand<CR>

" Ag with Ack
" ===============
let g:ackprg = 'ag --nogroup --nocolor --column --ignore-dir=drupal/static/src/js/vendor/ --ignore-dir=drupal/forum/ --ignore-dir=chef/cookbooks --ignore-dir=build/ --ignore-dir=blog/'
nnoremap K :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

" Fugitive
" ===============
autocmd QuickFixCmdPost *grep* cwindow

" Vim-Test
" ===============
let test#strategy = "vimux"

map <silent> <leader>r :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>

" FZF
" ===============
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>t :FZF<cr>

" BINDINGS
" ===============
command! Q q
command! Qall qall

" MAPPINGS
" ===============
" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

" Force to break the habit of using the arrow keys
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

"easy split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer navigation
nnoremap <C-n> :bn<CR>
nmap <C-p> :bp<CR>

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>
" copy file name to clip board
nmap cp :let @+=expand("%")<CR>

map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
" map <C-t> <Esc>:tabnew<CR>

" Tabs
vmap <Tab> >gv
vmap <S-Tab> <gv

" code complete
imap <Tab> <C-N>

" SETTINGS
" ==============
set autoindent
set backupdir=~/.tmp
set clipboard=unnamed
set complete-=t
set nocursorline
set directory=~/.tmp
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list listchars=tab:\|_,trail:·
set mouse=a
set nocompatible
set nofoldenable
set number
set relativenumber
set ruler
set showmode
set statusline=%<%f\ %h%m%r%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P
set ts=2 sts=2 sw=2 expandtab " Tabs and Spaces
set wildignore+=*.pyc
set wildmode=list:longest,full
if exists('+colorcolumn') " hint to keep lines short
  set colorcolumn=80
endif
" Window focus
" set winwidth=200
" set winheight=5
" set winminheight=5
" set winheight=999

" Cursor
set cul

" set up some custom colors
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif
