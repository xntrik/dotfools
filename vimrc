set nocompatible " not vi compatible

"--------------
" Load pathogen
"--------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them
set colorcolumn=80 " column marker

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    "colorscheme solarized
    colorscheme gruvbox
    " customized colors
    "highlight SignColumn ctermbg=234
    "highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    "highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    "let g:NeatStatusLine_color_normal='ctermfg=64 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_insert='ctermfg=136 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_replace='ctermfg=160 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_visual='ctermfg=33 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_position='ctermfg=245 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_modified='ctermfg=166 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_line='ctermfg=61 ctermbg=235 cterm=bold'
    "let g:NeatStatusLine_color_filetype='ctermfg=37 ctermbg=235 cterm=bold'
endif

filetype plugin indent on " enable file type detection
set autoindent

"---------------------
" Basic editing config
"---------------------
" remap ESC in insert mode to quickly pressing jk
inoremap jk <ESC>
let mapleader="\<Space>"
set nu " number lines
"set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
exec "set listchars=tab:>>,nbsp:~"
set lbr " line break
set ruler " show current position in file
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set noautochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

"--------------------
" Misc configurations
"--------------------

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" tab selection
nmap <F1> :tabn 1<CR>
nmap <F2> :tabn 2<CR>
nmap <F3> :tabn 3<CR>
nmap <F4> :tabn 4<CR>
nmap <F5> :tabn 5<CR>
nmap <F6> :tabn 6<CR>
nmap <F7> :tabn 7<CR>
nmap <F8> :tabn 8<CR>
nmap <F9> :tabn 9<CR>
nmap <F10> :tabn 10<CR>
nmap <F11> :tabl<CR>
nmap <C-t> :tabnew<CR>

"---------------------
" Plugin configuration
"---------------------

" deoplete
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" toggle Tagbar
nmap <F12> :TagbarToggle<CR>

" ctrlp
"nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1
nmap <Leader>p :CtrlPBuffer<CR>

" ag
let g:ag_mapping_message=0
command -nargs=+ Gag Gcd | Ag! <args>
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" airline powerline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1

" Buffergator cycling
nmap <Leader>v :BuffergatorMruCyclePrev<CR>
nmap <Leader>n :BuffergatorMruCycleNext<CR>

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
