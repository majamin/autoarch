"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|
" 				VIMRC

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p "$HOME/.config/nvim/autoload"
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vimwiki/vimwiki'
Plug 'jalvesaq/Nvim-R' " a plugin for R
Plug 'ap/vim-css-color' "previews colors for convenience
Plug 'jpalardy/vim-slime'
call plug#end()

"                           _   _       _
"   ___  ___ ___  ___ _ __ | |_(_) __ _| |___
"  / _ \/ __/ __|/ _ \ '_ \| __| |/ _` | / __|
" |  __/\__ \__ \  __/ | | | |_| | (_| | \__ \
"  \___||___/___/\___|_| |_|\__|_|\__,_|_|___/
"

filetype plugin indent on
let mapleader=","
let maplocalleader=';'
syntax on
colorscheme gruvbox
set clipboard+=unnamedplus " system clipboard
set spelllang=en_ca
set ruler
set nowrap
set nonumber
set scrolloff=9
set showmode
set nohlsearch
set history=50
set incsearch
set autochdir
set noswapfile
set hidden
set splitbelow splitright

set statusline=
set statusline+=\ %M 	"modified?
set statusline+=\ %F 	"full path
"set statusline+=%=
set statusline+=\ ----
set statusline+=\ %l/%L "line/out of
set statusline+=\ [%n] 	"buffer #

map <C-n> :vnew<CR>

map <F11> :bn<CR>
map <F10> :bp<CR>

" jump to the beginning and end of a line
nnoremap <S-h> g^
nnoremap <S-l> g$

" Simple window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Resize quickly
map <Up> :resize +2<CR>
map <Down> :resize -2<CR>
map <Left> :vertical resize -2<CR>
map <Right> :vertical resize +2<CR>

" quick terminal escape
tnoremap <Esc><Esc> <C-\><C-n>

" In insert mode, F12 to insert date and <S-F12> for a datetime
inoremap <F12> <C-r>=system("date +'\%F' \| tr '\n' ' '")<CR>
inoremap <F24> <C-r>=system("date +'\%F \%T \%Z' \| tr '\n' ' '")<CR>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" paste image paths found in working directory and up to sub-sub directories
" DEPS: sxiv, xclip
map <leader>i :r !find . -maxdepth 3 -print \| file -if - \| grep "image/" \| awk -F: '{print $1}' \| xargs sxiv -qto 2> /dev/null <CR><CR>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

let g:vimwiki_ext2syntax    = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let wiki_personal           = {}
let wiki_personal.path 		= system('printf "%s" "$ONEDRIVE" "/Projects/notes"')
let wiki_personal.path_html	= system('printf "%s" "$ONEDRIVE" "/Projects/notes/html"')
let g:vimwiki_list 		    = [wiki_personal]


let R_assign = 0
let r_indent_align_args = 0
autocmd FileType r setlocal ts=2
autocmd FileType r setlocal sw=2

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

let rout_follow_colorscheme = 1 "ORIGINAL
let r_syntax_folding = 1
set nofoldenable

"Goyo

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
