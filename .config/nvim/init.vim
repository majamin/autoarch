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
" Aesthetics
Plug 'chiendo97/intellij.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-rooter'
" Moving around
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" REPL
Plug 'jpalardy/vim-slime'
Plug 'jalvesaq/Nvim-R'
" LSP, Completion
" https://github.com/williamboman/nvim-lsp-installer
Plug 'williamboman/nvim-lsp-installer' | Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
call plug#end()

syntax on
filetype plugin indent on

let mapleader=","
let maplocalleader=';'

colorscheme intellij
"set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
hi CursorLine ctermbg=255 guibg=#EDEBC9
hi Search gui=bold,italic,undercurl guibg=NONE guifg=#FF1168
hi HopNextKey   guifg=#FF073B
hi HopNextKey2  guifg=#26C2FC
hi HopNextKey1  guifg=#0D84B0
hi HopUnmatched guifg=#CFD5E1
autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline
set completeopt=menu,menuone,noselect
set termguicolors cursorline relativenumber title clipboard+=unnamedplus
set spelllang=en_ca nowrap noshowmode history=50 incsearch
set nowrapscan autochdir noswapfile hidden splitbelow splitright
let g:airline_theme='light'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " show filenames only
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>Projects']

let html_number_lines=1

"autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType c,cpp setlocal cindent expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType r,javascript,html,css,scss setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

lua <<EOF

-- telescope
require'telescope'.setup {
	defaults = {
		path_display = { "truncate" }
		}
	}

-- hop
require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

-- lsp installer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {}
  server:setup(opts)
end)

-- trouble plugin
require("trouble").setup {}

-- LSP colors
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

EOF

"------------------------------------------------------------------------------

autocmd User DiagnosticsChanged lua vim.diagnostic.setqflist({open = false })

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
map <C-n> :vnew<CR>
nnoremap <S-h> :HopWordBC<CR>
nnoremap <S-l> :HopWordAC<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Up> :resize +2<CR>
map <Down> :resize -2<CR>
map <Left> :vertical resize -2<CR>
map <Right> :vertical resize +2<CR>
tnoremap <Esc><Esc> <C-\><C-n>
nnoremap <C-b> :bp\|bd #<CR>

" Using Lua functions
nnoremap <space><space> :Telescope<CR>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').git_bcommits({hidden=false})<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles({hidden=false})<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').file_browser({hidden=true})<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden=false})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep({hidden=false})<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" compiler
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" make line joins and jumps more natural
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" quit highlighting search results with ESC
noremap <silent> <ESC> :noh<CR>

" move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" In insert mode, F12 to insert date and <S-F12> for a datetime
inoremap <F12> <C-r>=system("date +'\%F' \| tr '\n' ' '")<CR>
inoremap <F24> <C-r>=system("date +'\%F \%T \%Z' \| tr '\n' ' '")<CR>

" nnoremap g= :execute '!git commit -m "'.input('Enter message: ').'"'<CR>
nnoremap g= :execute 'r !echo "'.input('Enter math expression: ').'" \| bc -l'<CR>

" look for visual selection
"vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" paste image paths found in working directory and up to sub-sub directories
" DEPS: sxiv, xclip
map <leader>i :r !find . -maxdepth 3 -print \| file -if - \| grep "image/" \| awk -F: '{print $1}' \| xargs sxiv -qto 2> /dev/null <CR><CR>

" Skeleton files
nnoremap <leader>ttoc :-1read $HOME/.config/nvim/.skeleton.ttoc<CR>:set filetype=asciidoc<CR>3jf>a
nnoremap <leader>html :-1read $HOME/.config/nvim/.skeleton.html<CR>:set filetype=html<CR>3jf>a
nnoremap <leader>cpp  :-1read $HOME/.config/nvim/.skeleton.cpp<CR>:set filetype=cpp<CR>3jf>a

" Automatically deletes all trailing whitespace and newlines at end of file on save.
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>:so ~/sessions/

"------------------------------------------------------------------------------
let g:vimwiki_global_ext = 0  " don't vimwiki every goddamn md file, please
let g:vimwiki_ext2syntax     = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let wiki_personal            = {}
let wiki_personal.path       = system('printf "%s" "$ONEDRIVE" "/Projects/notes"')
let wiki_personal.path_html  = system('printf "%s" "$ONEDRIVE" "/Projects/notes/html"')
let wiki_oneliners           = {}
let wiki_oneliners.path      = system('printf "%s" "$ONEDRIVE" "/Projects/oneliners.txt"')
let wiki_oneliners.path_html = system('printf "%s" "$ONEDRIVE" "/Projects/oneliners.txt/html"')
let wiki_oneliners.index     = 'oneliners'
let wiki_oneliners.ext       = 'txt'

let g:vimwiki_list           = [wiki_personal, wiki_oneliners]
" send VimwikiNextLink and Prev into a black hole
" vimwiki defaults this command to TAB which conflicts with my mappings:
nmap <S-F9> <Plug>VimwikiNextLink
nmap <S-F8> <Plug>VimwikiPrevLink

"------------------------------------------------------------------------------
let g:slime_no_mappings = 1
let g:slime_python_ipython = 1
autocmd FileType python xmap <Space> <Plug>SlimeRegionSend
autocmd FileType python nmap <Space> <Plug>SlimeParagraphSend
nmap <C-c>v <Plug>SlimeConfig
let g:slime_target = "tmux"

"------------------------------------------------------------------------------
let R_assign = 0
let r_indent_align_args = 0

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

let rout_follow_colorscheme = 1 "ORIGINAL
let r_syntax_folding = 1
set nofoldenable

