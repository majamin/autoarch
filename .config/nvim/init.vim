"                        _           
"  _ __   ___  _____   _(_)_ __ ___  
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \ 
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|
" 				VIMRC
"
" By Marian Minar
" Attributions - Luke Smith (of lukesmith.xyz)
"                Dr. Stackoverflow and Dr. Stackexchange

" The aim of the vimrc file is to provide a nice configuration.
" For additional plugins, add them to the list in the Plug section below.

" INSTRUCTIONS:
" 1. Install pywal (pip install pywal) if you want to use the wal plug.
" 2. In Vim, type :PlugInstall to fetch all of the plugins.

" NOTES:
" Leader key is ','
" Backup directory will be created at ~/.cache/nvim/backup
" Type ,ll to enter distraction-free typing.

" TIPS:
" type `:options` to see all of the ways you can customize Neovim.
" type `:so %` to reload this vimrc and see your changes



"  ____  _             
" |  _ \| |_   _  __ _ 
" | |_) | | | | |/ _` |
" |  __/| | |_| | (_| |    June Gunn's simple plugin manager
" |_|   |_|\__,_|\__, |
"                |___/ 

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p "$HOME/.config/nvim/autoload"
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'scrooloose/nerdtree'
Plug 'lukesmithxyz/vimling'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim' "focus directly what's in front of you
Plug 'jalvesaq/Nvim-R' " a plugin for R
Plug 'dylanaraps/wal.vim' " wal matches vim colors to the current wal theme
Plug 'baeuml/summerfruit256.vim' "great light-color theme (not used, yet)
Plug 'rafi/awesome-vim-colorschemes' "it's obvious what this is
call plug#end()




"                           _   _       _     
"   ___  ___ ___  ___ _ __ | |_(_) __ _| |___ 
"  / _ \/ __/ __|/ _ \ '_ \| __| |/ _` | / __|
" |  __/\__ \__ \  __/ | | | |_| | (_| | \__ \  stuff
"  \___||___/___/\___|_| |_|\__|_|\__,_|_|___/
"                                             

filetype plugin indent on "filetype detect, smart options, indent rules
let mapleader="," "mapleader key
syntax on "syntax highlighting
set clipboard+=unnamedplus "allows copying/pasting from system clipboard

if ! filereadable(expand('~/.cache/nvim/backup'))
	silent !mkdir -p ~/.cache/nvim/backup//
endif
set backupdir=$HOME/.cache/nvim/backup

"colorscheme alduin "enabled by plugin rafi/awesome-vim-colors
"colorscheme gotham "enabled by plugin rafi/awesome-vim-colors
"colorscheme elflord "it's not bad but the TODO is horendous
colorscheme angr 
"colorscheme jellybeans "enabled by plugin rafi/awesome-vim-colors
"colorscheme meta5 "enabled by plugin rafi/awesome-vim-colors
"colorscheme molokai "enabled by plugin rafi/awesome-vim-colors
"colorscheme wal "only works with pywal installed

set spelllang=en_ca
set backup "backup copy saved as '~<original-file>'
set ruler "display column, row, etc.
set number "display line numbers
set scrolloff=9
set visualbell " use a visual bell instead of beeping
set showmode " display the current mode in the status line
set splitright " opem split windows on the right
set hlsearch " type :noh to get rid of highlighted search results
set splitbelow splitright "open window splits on bottom and right
set backspace=indent,eol,start "<BS> is allowed to delete these
set autoindent "indent same amount as previous line
set history=50 "keep 50 commands and search history
set showcmd "display an incomplete command
set incsearch "display matches while you type
set magic "change how backslashes behave in searches
set encoding=utf-8
set mouse=a
set go=a

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

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Experimental TODO things
" I want Vim to detect if I have a TODO in a file and to add the path
" of the file to a 'todofiles.txt' simple database that I can search later.
"autocmd BufWrite
"	if echo("TODO", "cnw") > 0
"		r! echo % >> "~/todofiles.txt"
"	endif

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

"   __     __ 
"  / _|___/ _|
" | ||_  / |_ 
" |  _/ /|  _|  How did we ever do things before fzf?
" |_|/___|_|  
"             
" search for files starting in the home directory
nnoremap <leader>f 	:Files ~/<CR>
nnoremap <leader>fc 	:Files ~/.config<CR>
nnoremap <leader>fo 	:Files ~/OneDrive<CR>
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
let wiki_personal.path 		= '~/OneDrive/Maja/Documents/vimwiki_personal/'
let wiki_personal.path_html 	= '~/OneDrive/Maja/Documents/vimwiki_personal/html/'
let wiki_personal.syntax 	= 'markdown'
let wiki_personal.ext 		= '.md'
let wiki_mss 			= {}
let wiki_mss.path 		= '~/OneDrive/Maja/Documents/vimwiki_mss/'
let wiki_mss.path_html 		= '~/OneDrive/Maja/Documents/vimwiki_mss/html/'
let wiki_mss.syntax 		= 'markdown'
let wiki_mss.ext 		= '.md'
let g:vimwiki_list 		= [wiki_personal, wiki_mss]

" Vimwiki is nicer when there's no wrap
autocmd BufRead,BufNewFile */vimwiki* set nowrap


" __     ___           _ _             
" \ \   / (_)_ __ ___ | (_)_ __   __ _ 
"  \ \ / /| | '_ ` _ \| | | '_ \ / _` |
"   \ V / | | | | | | | | | | | | (_| |    for the dead keys
"    \_/  |_|_| |_| |_|_|_|_| |_|\__, |    LukeSmithxyz
"                                |___/ 

nm <leader><leader>d :call ToggleDeadKeys()<CR>
imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
nm <leader><leader>i :call ToggleIPA()<CR>
imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
nm <F8> :call ToggleProse()<CR>


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
