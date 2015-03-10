"==================================================================
" BOOTSTRAP
"==================================================================

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible  " Be iMproved
 endif

 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'drmingdrmer/xptemplate'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'fatih/vim-go'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'johnadamson/ZoomWin.vim'
" NeoBundle 'joonty/vdebug'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make'
      \    },
      \ }
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/ctags.vim'
NeoBundle 'vim-scripts/jsbeautify'
NeoBundle 'vim-scripts/openssl.vim'
NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'widox/vim-buffer-explorer-plugin'

call neobundle#end()

filetype plugin indent on

" Install bundles that don't exist 
NeoBundleCheck


"==================================================================
" GENERAL OPTIONS
"==================================================================

" To profile for performance issues, use:
" :profile start profile.log
" :profile func *
" :profile file *
" <At this point do slow actions>
" :profile pause
" :noautocmd qall!

syntax enable

let mapleader = ","
set autoread                      " when file changes outside of vim, reload
set backspace=indent,eol,start
set history=50
set hlsearch                      " do search highlighting
set ignorecase smartcase          " searches case-sensitive only if they contain upper-case characters
set incsearch                     " do incremental searching
set lazyredraw                    " dont redraw screen while executing commands, macros, etc.
set laststatus=2                  " always display the status line
set list listchars=tab:▸\ ,trail:· " display tabs and trailing whitespace
set nobackup
set noswapfile
set nowrap
set nowritebackup
set number
set numberwidth=5
set ruler                         " show the cursor position all the time
set scrolloff=10                  " screen lines to keep above and below the cursor
set shortmess+=I                  " don't show startup message
set showcmd                       " display incomplete commands
set splitbelow                    " split window with new one on bottom
set synmaxcol=1000
set timeoutlen=500                " delay for keystroke shortcuts
set ttimeoutlen=0                 " delay for key codes
set ttyfast
set virtualedit=all               " allow the cursor to go in to 'invalid' places

set undofile                      " Store indefinite undo
let &undodir=expand('~/.vim/.undodir')

" Color scheme
set t_Co=256
highlight Search     cterm=NONE ctermfg=black
highlight Folded     cterm=NONE ctermfg=250   ctermbg=239
highlight Pmenu      cterm=NONE ctermfg=black
highlight PmenuSel   cterm=NONE ctermfg=white ctermbg=blue
highlight Spellbad   cterm=NONE ctermfg=black
highlight Visual     cterm=NONE ctermfg=black ctermbg=yellow
highlight DiffAdd    cterm=NONE ctermfg=black
highlight DiffChange cterm=NONE ctermfg=black
highlight DiffDelete cterm=NONE ctermfg=black
highlight DiffText   cterm=NONE ctermfg=black

" Tab completion
" will insert tab at beginning of line
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t

" Override options with local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Set syntax folding method
set foldmethod=syntax
set foldlevelstart=99

"==================================================================
" FILE TYPE OPTIONS
"==================================================================

filetype plugin indent on
augroup vimrcEx
  au!

  autocmd BufEnter * :syntax sync fromstart    " The file will be parsed from the start 
  autocmd FileType ruby setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType php setlocal foldmethod=indent shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType text setlocal textwidth=78
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 makeprg=go\ build
  autocmd FileType go setlocal nolist
  autocmd FileType go map <buffer> <leader>r :GoTest<CR>
  autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

  " Jump to the last known cursor position when opening a file, but only if
  " the position is not invalid or in an event handler.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

"==================================================================
" PLUGIN OPTIONS
"==================================================================

" So CHRUBY will be activated
set shell=$SHELL\ -l

" XPTemplate
let g:xptemplate_snippet_folders=[$HOME . '/.vim/snippets']

" Vroom
let g:vroom_use_bundle_exec=1
let g:vroom_clear_screen=0

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors=1
let g:syntastic_auto_loc_list=2
let g:syntastic_enable_highlighting=0

" Ctrlp
let g:ctrlp_working_path_mode = 0     " don't manage working directory
let g:ctrlp_clear_cache_on_exit = 0   " remember cache from previous session
let g:ctrlp_lazy_update = 25          " delay before updating results
let g:ctrlp_max_height = 30
let g:ctrlp_user_command = 'ag %s -a -l --nocolor -g ""'
let g:ctrlp_custom_ignore = { 'dir': '\v[\/]\.(\.git|vendor\/vendor\/bundle)$' }
let g:ctrlp_switch_buffer = 'et'

" Nerd Tree Options
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.DS_Store']

" CTags / Rails.vim
" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

let g:vdebug_options = {
\    "timeout" : 20,
\    "break_on_open" : 1,
\    "watch_window_style" : 'compact',
\    "continuous_mode" : 1
\}
"    \    "port" : 9000,
"    \    "server" : 'localhost',
"    \    "timeout" : 20,
"    \    "on_close" : 'detach',
"    \    "break_on_open" : 1,
"    \    "ide_key" : '',
"    \    "path_maps" : {},
"    \    "debug_window_level" : 0,
"    \    "debug_file_level" : 0,
"    \    "debug_file" : "",
"    \    "watch_window_style" : 'expanded',
"    \    "marker_default" : '⬦',
"    \    "marker_closed_tree" : '▸',
"    \    "marker_open_tree" : '▾'
"    \}
"\}

let g:tagbar_type_go = {  
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
  \   'p:package',
  \   'i:imports:1',
  \   'c:constants',
  \   'v:variables',
  \   't:types',
  \   'n:interfaces',
  \   'w:fields',
  \   'e:embedded',
  \   'm:methods',
  \   'r:constructor',
  \   'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
  \   't' : 'ctype',
  \   'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
  \   'ctype' : 't',
  \   'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

"==================================================================
" KEY BINDINGS
"==================================================================

" Format entire file
nmap <leader>fef ggVG=``

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Toggle hlsearch
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

map <leader>` :call EditVimrcConfig()<cr>

" no annoying message
command W w
command WQ wq
command Wq wq
command Q q
command Qall qall
command Tabe tabe
command TAbe tabe

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" clipper integration
nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

" Format JSON
command! FormatJSON silent %!python -m json.tool

" Format XML
command! FormatXML silent %!xmllint --encode UTF-8 --format -

" Format Ruby Hash
command! FormatRubyHash silent %!ruby -r'pp' -e "pp(`cat %`)"

" Show NERDTree
map <leader>n :NERDTreeTabsToggle<CR>

" open buffer in marked
command! Marked silent !open -a "Marked.app" "%:p"

" ZoomWin
nnoremap <leader>zw :ZoomWin<CR>

" New Tab
map <leader>nt :tabe<CR>

" Tabularize align
nnoremap <leader>th :Tabularize /=><CR>
vnoremap <leader>th :Tabularize /=><CR>
nnoremap <leader>te :Tabularize /=<CR>
vnoremap <leader>te :Tabularize /=<CR>
nnoremap <leader>tj :Tabularize /:\zs/l0c1l0<CR>
vnoremap <leader>tj :Tabularize /:\zs/l0c1l0<CR>
nnoremap <leader>tt :Tabularize /^\S\+\zs/l0c1l0<CR>
vnoremap <leader>tt :Tabularize /^\S\+\zs/l0c1l0<CR>
nnoremap <leader>ts :Tabularize /\S*\s\{2,}\zs/l3l3l3<CR>
vnoremap <leader>ts :Tabularize /\S*\s\{2,}\zs/l3l3l3<CR>
nnoremap <leader>tc :Tabularize /,\zs/l0c1l1<CR>
vnoremap <leader>tc :Tabularize /,\zs/l0c1l1<CR>

" AddTabularPattern! js /:\zs/l0c1l0

" Fast save
nnoremap <leader>w :w<CR>

" Write as sudo
cnoremap w!! w !sudo tee > /dev/null "%"

" Toggle Relative and absolute numbering
nnoremap <leader>tn :call NumberToggle()<CR>

"==================================================================
" FUNCTIONS
"==================================================================

function! EditVimrcConfig()
  e ~/.vimrc
endfunction

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\s\(\w\+\) = \(.*\)$/let(:\1){ \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()

function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set relativenumber
    set nonumber
  endif
endfunc

" vim: ft=vim
