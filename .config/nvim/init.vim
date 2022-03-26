" My little Neovim VIMRC

" !mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/"
" !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-sleuth'
Plug 'vimwiki/vimwiki'
Plug 'romgrk/github-light.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'maxmellon/vim-jsx-pretty'  
Plug 'othree/javascript-libraries-syntax.vim'  
Plug 'pangloss/vim-javascript'
" vim surround
" hop
" vim-commentary
" vim-slime

call plug#end()

let mapleader=" "

setl nospell
setl nowrap
setl tabstop=4
setl shiftwidth=4
setl smartindent
setl expandtab
let b:vcm_tab_complete = 'javascript'
let b:javascript_fold = 1
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
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

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

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
