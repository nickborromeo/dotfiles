" Vundle Setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

 " let Vundle manage Vundle
 Bundle 'gmarik/vundle'

" My Bundles
" ===============
Bundle 'benmills/vimux'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'chrisbra/csv.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'gioele/vim-autoswap'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'kchmck/vim-coffee-script'
Bundle 'koron/nyancat-vim'
Bundle 'ludovicchabant/vim-gutentags'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'mileszs/ack.vim'
Bundle 'nono/jquery.vim'
Bundle 'nrocco/vim-phplint'
Bundle 'pangloss/vim-javascript'
Bundle 'rodjek/vim-puppet'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vinegar'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/dbext.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'wincent/Command-T'
Bundle 'wojtekmach/vim-rename'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'

" Get that filetype stuff happening
filetype on

let mapleader = ","

nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
" Git Stuff
map <Leader>ga :Git add
map <Leader>gad :Git add .<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gcv :Gcommit --verbose<CR>
map <Leader>gs :Gstatus<CR>
" map <Leader>s :sh
map <Leader>gb :Git branch<CR>
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
" nnoremap <leader>s :w<cr>
" inoremap <leader>s <C-c>:w<cr>

" vimux
let g:VimuxPromptString = ""
map <Leader>op :VimuxRunCommand("")<CR>
map <Leader>cp :VimuxCloseRunner<CR>
map <Leader>vc :VimuxPromptCommand<CR>
map <Leader>pi :call VimuxRunCommand("python")<CR>
map <Leader>vu :call VimuxRunCommand("cd /Users/nickb/Work/Minted/minted && vagrant up")<CR>
map <Leader>vg :call VimuxRunCommand("vagrant ssh")<CR>

" Command-T
" ===============
let g:CommandTMaxHeight = 10
let g:CommandTMaxFiles = 50000
let g:CommandTMaxDepth = 30
let g:CommandTInputDebounce = 200
let g:CommandTFileScanner = 'git'

" Notes
" ===============
let g:notes_directories = ['~/Dropbox/minted_notes']

" BufExplorer
" ===============
map <leader>be :BufExplorerHorizontalSplit<CR>

" Ag with Ack
" ===============
let g:ackprg = 'ag --nogroup --nocolor --column --ignore-dir=drupal/static/src/js/vendor/ --ignore-dir=drupal/forum/ --ignore-dir=chef/cookbooks --ignore-dir=build/ --ignore-dir=blog/'
nnoremap K :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

" Fugitive
" ===============
autocmd QuickFixCmdPost *grep* cwindow

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
set macmeta
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
" THEMES
" ===============
syntax on
" light theme
" set background=light
" colors solarized

" dark theme
set background=dark
colors base16-railscasts
" colors benlight

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
     exec ":!rspec --color " . a:filename
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
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.py)$') != -1
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

function! RunVagrantTest()
  :w
  :silent !clear
  let t:grb_test_file=@%
  exec ":!clear && tmux send-keys -t bottom 'vagrant ssh -- sudo env MINTED_CONF_PATH=/srv/minted/etc/www.yml PYTHONPATH=/srv/minted/releases/latest/py/ nosetests /vagrant/" .  t:grb_test_file . "' C-m"
endfunction

map <leader>r :call RunVagrantTest()<cr>
" map <leader>s :call RunTestFile()<cr>
" map <leader>S :call RunNearestTest()<cr>


function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set nonumber
    set relativenumber
  endif
endfunc

map <leader>n :call NumberToggle()<cr>

if has("autocmd")
  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set t_Co=256                        " force vim to use 256 colors
let g:solarized_termcolors=256      " use solarized 256 fallback

" Read Database Profiles
source /Users/nickb/.dotfiles/vim/dbext/dbext-profiles.vim
