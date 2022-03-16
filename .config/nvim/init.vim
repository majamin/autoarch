" My little Neovim VIMRC

" !mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/"
" !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-sleuth'
Plug 'vimwiki/vimwiki'
Plug 'romgrk/github-light.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let mapleader=" "

set clipboard+=unnamedplus
set termguicolors
set cursorline
colorscheme github-light
"hi CursorLine ctermbg=255 guibg=#c7efff
"set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set spelllang=en_ca
map <F3> :setlocal spell! spelllang=en_ca<CR>

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

"====COC STUFF==================================================================
"function! s:check_back_space() abort
"	let col = col('.') - 1
"	return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <TAB>
"			\ pumvisible() ? "\<C-n>" :
"			\ <SID>check_back_space() ? "\<TAB>" :
"			\ coc#refresh()

inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ?
	\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"====VIMWIKI STUFF==============================================================



let g:vimwiki_global_ext = 0  " don't vimwiki every goddamn md file, please
let g:vimwiki_ext2syntax     = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let wiki_personal            = {}
let wiki_personal.path       = system('printf "%s" "$ONEDRIVE" "/Projects/notes"')
let wiki_personal.path_html  = system('printf "%s" "$ONEDRIVE" "/Projects/notes/html"')
let g:vimwiki_list           = [wiki_personal]

" Vimwiki maps <tab> to these, which is a conflict - bury them.
nmap <S-F9> <Plug>VimwikiNextLink
nmap <S-F8> <Plug>VimwikiPrevLink

" Expose the entire URL so you can plumb from terminal emulators
let g:vimwiki_url_maxsave = 0
