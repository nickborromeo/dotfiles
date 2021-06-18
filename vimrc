" THEMES
" ===============
colors gruvbox
let g:gruvbox_contrast_dark = "medium"
set bg=dark

" My Plugins
" ===============
call plug#begin('~/.vim/plugged')

Plug 'benmills/vimux'
Plug 'bronson/vim-trailing-whitespace'
Plug 'bswinnerton/vim-test-github'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'koron/nyancat-vim'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

call plug#end()

" Get that filetype stuff happening
filetype plugin on

let mapleader = ","

" Git Stuff
map <Leader>gs :Git<CR>
map <Leader>gb :Git blame<CR>
map <Leader>gh :GBrowse<CR>
map <Leader>gl :vert term git log %<CR>

"Rails
map <Leader>m :Vmodel<CR>
map <Leader>c :Vcontroller<CR>
map <Leader>tt :RV<CR>

" Utilities
map <Leader>hs :split
map <Leader>vs :vsplit
map <Leader>a :Rg
map <Leader>fw :FixWhitespace<CR>
map <Leader>tn :tabnew<CR>
map <Leader>tc :tabclose<CR>

" vimconfig
nmap <leader>v :tabedit $MYVIMRC<CR>

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>
map <Leader>i mmgg=G`m<CR>

" ctags refresh
map <Leader>ct :!git ls-files \| ctags -L - --tag-relative=yes --extras=+f -Rf.git/tags --languages=-javascript,sql<cr><cr>
" fast save and quit
noremap <leader>q :q<cr>
nnoremap <leader>s :w<cr>
" inoremap <leader>s <C-c>:w<cr>
"
" netrw
map <Leader>ft :Lexplore<CR>

" vimux
let g:VimuxPromptString = ""
map <Leader>op :VimuxRunCommand("")<CR>
map <Leader>cp :VimuxCloseRunner<CR>
map <Leader>vc :VimuxPromptCommand<CR>

nnoremap K :Rg<CR>

" Fugitive
" ===============
autocmd QuickFixCmdPost *grep* cwindow
au FileType gitcommit setl tw=120

" Vim-Test
" ===============
let test#runners = {'Ruby': ['GitHub']}
let test#strategy = "vimux"

map <silent> <leader>r :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>

" FZF
" ===============
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>t :FZF<cr>

" CoAuthor
" ===============
command Hubber ! listhubbers | fzy
command! CoAuthor r! echo "Co-authored-by: $(listhubbers | fzy)"

" BINDINGS
" ===============
command! Q q
command! Qall qall

" MAPPINGS
" ===============
" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

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
" imap <Tab> <C-N>
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use K to show documentation in preview window.
nnoremap <silent> L :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Go To Actions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv :vsp<CR><Plug>(coc-definition)

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
set ma " modifiable buffer
set nocompatible
set nofoldenable
set number
" set relativenumber
set re=1
set ruler
set splitright
set showmode
" set statusline=%<%f\ %h%m%r%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P
set ts=2 sts=2 sw=2 expandtab " Tabs and Spaces
" set t_ti= t_te=
set tw=120
set wildignore+=*.pyc
set wildmode=list:longest,full
if exists('+colorcolumn') " hint to keep lines short
  set colorcolumn=120
endif

" Window focus
set winheight=5
set winminheight=5
set winheight=999

" Cursor
set cul
set virtualedit=all

" Search
nnoremap <C-n> :silent! nohls<cr>

" set up some custom colors
highlight Visual       cterm=bold ctermbg=11   ctermfg=239
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=235 ctermfg=12

if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=235 ctermfg=12
endif

if exists('termguicolors')
  set termguicolors
endif

" Workarounds
" There is a bug with gx that it will not open a url in the browser anymore
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>
