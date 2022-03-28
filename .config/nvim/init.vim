"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|RC

" Installs vim-plug by default
" Uses COC for completion, snippets
" Telescope for file hopping, in-file searching

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p "$HOME/.config/nvim/autoload"
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'romgrk/github-light.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'
call plug#end()

let mapleader=" "
colorscheme github-light

set nospell
set nowrap
set nowrapscan
set clipboard+=unnamedplus
set termguicolors
set cursorline

set spelllang=en_ca
map <F3> :setlocal spell! spelllang=en_ca<CR>

"====WINDOWS AND BUFFERS========================================================
" A buffer is the in-memory text of a file.
" A window is a viewport on a buffer.
" A tab page is a collection of windows.

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nnoremap <C-b> :bp\|bd #<CR>
nnoremap <C-q> :close<CR>
map <C-n> :enew<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Up> :resize +2<CR>
map <Down> :resize -2<CR>
map <Left> :vertical resize -2<CR>
map <Right> :vertical resize +2<CR>
tnoremap <Esc><Esc> <C-\><C-n>

"====HELPERS AND SHELL==========================================================
" maintain selection while tabbing lines
vmap < <gv
vmap > >gv

" search for selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" spell-check toggle, <ESC> turns of highlighting
map <F3> :setlocal spell! spelllang=en_ca<CR>
map <F4> :setlocal spell! spelllang=en-basic<CR>
noremap <silent> <ESC> :noh<CR>

function! <SID>StripTrailingWhitespaces()
       let l = line(".")
       let c = col(".")
       %s/\s\+$//e
       call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

nnoremap <leader>adoc :-1read $HOME/.config/nvim/.skeleton.adoc<CR>:set filetype=asciidoc<CR>
nnoremap <leader>ttoc :-1read $HOME/.config/nvim/.skeleton.ttoc<CR>:set filetype=asciidoc<CR>3jf>a
nnoremap <leader>html :-1read $HOME/.config/nvim/.skeleton.html<CR>:set filetype=html<CR>5jf>a
nnoremap <leader>cpp  :-1read $HOME/.config/nvim/.skeleton.cpp<CR>:set filetype=cpp<CR>3jf>a

nnoremap g= :execute 'r !echo "'.input('Enter math expression: ').'" \| bc -l '<CR>

inoremap <F12> <C-r>=system("date +'\%F' \| tr '\n' ' '")<CR>
inoremap <F24> <C-r>=system("date +'\%F \%T \%Z' \| tr '\n' ' '")<CR>

" https://raw.githubusercontent.com/LukeSmithxyz/voidrice/master/.local/bin/compiler
map <leader>c :w! \| !compiler "<c-r>%"<CR>

"====FILETYPE===================================================================
" NOTE: Tab stops and expansions is not required if using vim-polyglot

" autocmd FileType html,javascript set tabstop=2 | set softtabstop=2 | set shiftwidth=2 | set expandtab

"====COC STUFF==================================================================
" CONFIG:
" https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
" AVAILABLE EXTENSIONS:
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
" NOTE:
" For any of this to work, you need to install an extension for your filetype

let g:coc_global_extensions = ['coc-lists', 'coc-pairs', 'coc-prettier', 'coc-snippets']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

imap <C-l> <Plug>(coc-snippets-expand)

"====TELESCOPE==================================================================
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <leader><leader> <cmd>Telescope<cr>

"====VIMWIKI STUFF==============================================================

let g:vimwiki_global_ext     = 0  " Don't vimwiki every goddamn md file, please
let g:vimwiki_url_maxsave    = 0  " Don't shorten URL so you can plumb links
"let g:vimwiki_ext2syntax     = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let wiki_personal            = {}
let wiki_personal.path       = system('printf "%s" "$ONEDRIVE" "/Projects/notes"')
let wiki_personal.path_html  = system('printf "%s" "$ONEDRIVE" "/Projects/notes/html"')
let g:vimwiki_list           = [wiki_personal]

" I'm already using TAB to switch buffers
" (Vimwiki is rude and maps TAB automatically)
nmap <S-F9> <Plug>VimwikiNextLink
nmap <S-F8> <Plug>VimwikiPrevLink


