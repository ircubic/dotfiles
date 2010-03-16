set nocompatible

set shortmess+=r
set swb=useopen,usetab

set showmode
set showcmd
set cmdheight=2

set mouse=a
set backspace=eol,start,indent

set tabstop=4 shiftwidth=4
"set softtabstop=4
set shiftround
set noexpandtab
set autoindent

set history=50
set ruler
set showcmd
set incsearch
set textwidth=80
set nowrap
set scrolloff=6
set timeoutlen=200
set clipboard=autoselect

set matchpairs+=<:>

set updatetime=3600000
set updatecount=50
set formatoptions-=t formatoptions+=c


set smartindent
let g:asmsyntax="nasm"

" Change some formatting/syntax things for various file types
if has("autocmd")
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END
else
  set autoindent
endif


" Find filetype based upon filename
augroup filetype
  au BufNewFile,BufRead *.txt set filetype=human
  au BufNewFile,BufRead *.z80 set filetype=z8a
  au BufNewFile,BufRead *.inc set filetype=php
  au BufNewFile,BufRead *.tpl set filetype=php
  au BufNewFile,BufRead SConstruct set filetype=python
  au BufNewFile,BufRead *.mako set filetype=mako
  au BufNewFile,BufRead *.boo set filetype=boo
augroup END

syntax enable
"au FileType human set formatoptions+=t textwidth=80

"au FileType c,cpp,java set cindent cino+=:0,g0,(0 
"au FileType c,cpp,java let g:load_doxygen_syntax=1
"au FileType c,cpp,java let g:doxygen_javadoc_autobrief=0
" Have to run this here, even if it's been run before, to make it load doxygen
" syntax
"syntax on

"au FileType c set formatoptions+=ro

"au FileType perl set smartindent

au FileType css set smartindent

"au FileType html,xhtml set formatoptions+=tl noexpandtab tabstop=2 shiftwidth=2 softtabstop=0

"au FileType make set noexpandtab shiftwidth=8 softtabstop=0

"au FileType changelog set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0

" Some search defaults
set ignorecase
set smartcase

set incsearch
set nohlsearch

set gdefault

" Abbrevs
abbreviate teh the

" Eh...
set whichwrap=h,l,~,[,]

" Window, Tab, and args mappings
nnoremap <F6> <C-W>w
nnoremap <F5> <C-W>W

nnoremap <F7> gT
nnoremap <F8> gt

nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

nnoremap Q gqap
vnoremap Q gq

noremap Y y$


" For pasting :)
noremap <F10> :set paste<CR>
noremap <F11> :set nopaste<CR>
inoremap <F10> <C-O>:set paste<CR>
inoremap <F11> <nop>
set pastetoggle=<F11>

" Mappings for use when programming
nnoremap <F2> :w<CR>:make<CR>
nnoremap <F3> :wall<CR>:make<CR>

nnoremap <F9> <C-]>

" Folding
set foldmethod=marker

let color_scheme=1
if !has("gui_running")
	" Set up color stuff
	if &term =~ "rxvt-unicode"
		set t_Co=88
	elsei &term =~ "screen"
		set t_Co=256
	elsei &term =~ "xterm"
		set t_Co=256
	else
		let color_scheme=0
		set t_Co=16
		set background=dark
		highlight TabLine ctermfg=Grey ctermbg=DarkBlue cterm=NONE
		highlight TabLineFill ctermbg=DarkBlue cterm=NONE
		highlight TabLineSel ctermfg=DarkCyan ctermbg=DarkBlue cterm=NONE
		highlight Folded ctermbg=none ctermfg=DarkCyan
	endif
	if color_scheme == 1
		let g:inkpot_no_background = 1
		colorscheme inkpot
	endif
endif


set tags+=~/.vim/systags
