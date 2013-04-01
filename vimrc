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
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'mileszs/ack.vim'

" Get that filetype stuff happening
filetype on
 
" THEMES
" ===============
syntax on
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
" CtrlP
map <Leader>f :CtrlP<CR>

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
highlight StatusLine ctermfg=blue ctermbg=yellow
set autoindent
set backupdir=~/.tmp
set directory=~/.tmp
set hidden
set hlsearch
set incsearch
set lazyredraw
set mouse=a
set nocompatible
set nofoldenable
set number
set ruler
set showmode
set ts=2 sts=2 sw=2 expandtab " Tabs and Spaces
set wildmode=list:longest,full
set t_Co=256

" Custom Functions
" ==============

" run rspec tests, via Gary Bernhardt
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
     exec ":!bundle exec rspec --color " . a:filename
   else
     exec ":!rspec --color " . a:filename
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

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
