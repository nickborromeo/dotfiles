" Vundle Setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

 " let Vundle manage Vundle
 Bundle 'gmarik/vundle'

" My Bundles
" ===============
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'mileszs/ack.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'nono/jquery.vim'
Bundle 'wojtekmach/vim-rename'
Bundle 'bronson/vim-trailing-whitespace'

" Get that filetype stuff happening
filetype on

" THEMES
" ===============
let g:solarized_termcolors=256
syntax enable
colors molokai

let mapleader = ","

nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
" Git Stuff
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>ga :Git add 
map <Leader>s :sh
map <Leader>m :Rmodel 
map <Leader>vm :RVmodel 
map <Leader>sm :RSmodel
map <Leader>c :Rcontroller 
map <Leader>vc :RVcontroller 
map <Leader>sc :RScontroller
map <Leader>v :Rview 
map <Leader>vv :RVview 
map <Leader>sv :RSview
map <Leader>hs :split 
map <Leader>vs :vsplit 
map <Leader>a :vnew<cr>:Ack 
map <Leader>fw :FixWhitespace<CR>
map <Leader>h :nohl<CR>
map <Leader>tn :tabnew<CR>
map <Leader>tc :tabclose<CR>

"" Quick Theme Change
map <Leader>l :colorscheme solarized<CR>
map <Leader>d :colorscheme molokai<CR>

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>
map <Leader>i mmgg=G`m<CR>

" Command-T
" ===============
let g:CommandTMaxHeight = 10
let g:CommandTMaxFiles = 50000
let g:CommandTMaxDepth = 30


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
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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

" Project Navigation
map <C-t> :NERDTreeToggle<CR>

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
set directory=~/.tmp
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set mouse=a
set nocompatible
set nofoldenable
set relativenumber
set ruler
set showmode
set ts=2 sts=2 sw=2 expandtab " Tabs and Spaces
set wildmode=list:longest,full
set t_Co=256
set list listchars=tab:\|_,trail:·
" Window focus
set winwidth=200
set winheight=5
set winminheight=5
set winheight=999

highlight StatusLine ctermfg=67 ctermbg=yellow
" Custom Functions
" ==============

" " run rspec tests, via Gary Bernhardt
function! RunTests(filename)
 " Write the file and run tests for the given filename
 :w
 :silent !clear
 if match(a:filename, '\.feature$') != -1
   exec ":!script/features " . a:filename
 else
   if filereadable("script/test")
     exec ":!script/test " . a:filename
   elseif filereadable("Gemfile")
     exec ":!zeus rspec --color " . a:filename
   else
     exec ":!zeus rspec --color " . a:filename
   end
 end
endfunction

function! SetTestFile()
 " Set the spec file that tests will be run for.
 let t:grb_test_file=@%
endfunction

function!  RunTestFile(...)
 if a:0
   let command_suffix = a:1
 else
   let command_suffix = ""
 endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>s :call RunTestFile()<cr>
map <leader>S :call RunNearestTest()<cr>


