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
Plug 'scrooloose/nerdtree'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim' "focus directly what's in front of you
Plug 'jalvesaq/Nvim-R' " a plugin for R
Plug 'rafi/awesome-vim-colorschemes' "it's obvious what this is
Plug 'rust-lang/rust.vim'
call plug#end()

"                           _   _       _     
"   ___  ___ ___  ___ _ __ | |_(_) __ _| |___ 
"  / _ \/ __/ __|/ _ \ '_ \| __| |/ _` | / __|
" |  __/\__ \__ \  __/ | | | |_| | (_| | \__ \
"  \___||___/___/\___|_| |_|\__|_|\__,_|_|___/
"                                             

filetype plugin on
filetype indent on
let mapleader=","
syntax on
colorscheme afterglow 
set clipboard+=unnamedplus "allows copying/pasting from system clipboard
set spelllang=en_ca
set backspace=indent,eol,start "<BS> is allowed to delete these
set backup "backup copy saved as '~<original-file>'
set ruler
set nowrap "don't wrap unless I really need it
set nonumber
set scrolloff=9
set showmode "display the current mode in the status line
set splitbelow splitright "open split windows on the right
"set hlsearch "type :noh to get rid of highlighted search results
"set autoindent "indent same amount as previous line
set history=50 "keep 50 commands and search history
"set showcmd "display an incomplete command
set incsearch "display matches while you type
set magic "change how backslashes behave in searches
set encoding=utf-8
set mouse=a
set go=a

" backups
if ! filereadable(expand('~/.cache/nvim/backup'))
	silent !mkdir -p ~/.cache/nvim/backup//
endif
set backupdir=$HOME/.cache/nvim/backup

" jump to the beginning and end of a line
nnoremap <S-h> ^
nnoremap <S-l> $

" move a line up/down
nnoremap <S-j> :move +1<CR>
nnoremap <S-k> :move -2<CR>

" Simple window navigation using <C-*>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" In insert mode, F12 to insert date and <S-F12> for a datetime
inoremap <F12> <C-r>=system("date +'\%F' \| tr '\n' ' '")<CR>
inoremap <F24> <C-r>=system("date +'\%F \%T \%Z' \| tr '\n' ' '")<CR>

map <leader>c :w! \| !compiler <c-r>%<CR>
map <leader>ap :w! \| !bundle exec asciidoctor-revealjs <c-r>%<CR>
map <leader>p :!opout <c-r>%<CR><CR>

" paste image paths found in working directory and up to sub-sub directories
" DEPS: sxiv, xclip
map <leader>i :r !find . -maxdepth 2 -print \| file -if - \| grep "image/" \| awk -F: '{print $1}' \| xargs sxiv -qto<CR><CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"   __     __ 
"  / _|___/ _|
" | ||_  / |_   Fuzzy File Finder
" |  _/ /|  _|  How did we ever do things before fzf?
" |_|/___|_|  
"             
" search for files starting in the home directory
nnoremap <leader>f 	:Files <CR>
nnoremap <leader>ff	:Files ~/<CR>
nnoremap <leader>b 	:Buffers<CR>


" __   _(_)_ __ _____      _(_) | _(_)
" \ \ / / | '_ ` _ \ \ /\ / / | |/ / |
"  \ V /| | | | | | \ V  V /| |   <| |   Organize ideas and notes
"   \_/ |_|_| |_| |_|\_/\_/ |_|_|\_\_|
" KEYBINDINGS:
" ,ww	opens primary vimwiki
" ,ws	opens a selection menu for vimwiki

" vimwiki syntax TODO is this really necessary?
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" where's vimwiki?
let wiki_personal 		= {}
let wiki_personal.path 		= system('printf "%s" "$ONEDRIVE" "/Projects/vimwiki_personal"')
let wiki_personal.path_html	= system('printf "%s" "$ONEDRIVE" "/Projects/vimwiki_personal/html"')
let wiki_personal.syntax 	= 'markdown'
let wiki_personal.ext 		= '.md'
let wiki_mss 			= {}
let wiki_mss.path 		= system('printf "%s" "$ONEDRIVE" "/Projects/mss/vimwiki"')
let wiki_mss.path_html 		= system('printf "%s" "$ONEDRIVE" "/Projects/mss/vimwiki/html"')
let wiki_mss.syntax 		= 'markdown'
let wiki_mss.ext 		= '.md'
let g:vimwiki_list 		= [wiki_personal, wiki_mss]

" Vimwiki is nicer when there's no wrap
autocmd BufRead,BufNewFile */vimwiki* set nowrap

"   ____                   
"  / ___| ___  _   _  ___  
" | |  _ / _ \| | | |/ _ \ 
" | |_| | (_) | |_| | (_) |   Distraction-free editing
"  \____|\___/ \__, |\___/ 
"              |___/       

noremap <leader>ll :Goyo<CR>

" stuff that happens when we enter distraction-free writing
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

" stuff that happens when we leave distraction-free writing
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


"  ____  
" |  _ \ 
" | |_) |
" |  _ < 
" |_| \_\    Nvim-R is my R IDE
        
let maplocalleader = ';'

" Get rid of the absolutely insane binding the _ turns into <-
let R_assign = 0

" R indentation
" NOTE: r.vim in ~/.config/nvim/after/ftplugin
let r_indent_align_args = 0
autocmd FileType r setlocal ts=2
autocmd FileType r setlocal sw=2

" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" R output will follow current colorscheme
let rout_follow_colorscheme = 1 "ORIGINAL
" TODO READING help file :help Rout_more_colors
" let Rout_more_colors = 1
