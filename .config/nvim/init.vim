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
Plug 'hzchirs/vim-material'
Plug 'vimwiki/vimwiki'
Plug 'jalvesaq/Nvim-R'
Plug 'ap/vim-css-color'
Plug 'jpalardy/vim-slime'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
call plug#end()

syntax on
filetype plugin indent on

let mapleader=","
let maplocalleader=';'

set termguicolors
let g:material_style = 'oceanic'
colorscheme vim-material

set title
set clipboard+=unnamedplus
set spelllang=en_ca
"set ruler
set nowrap
set nonumber
set scrolloff=9
set showmode
"set nohlsearch
set history=50
set incsearch
set autochdir
set noswapfile
set hidden
set splitbelow splitright

set statusline=
set statusline +=%5*\ %n\ %*            "buffer number
set statusline +=%1*%{&ff}%*            "file format
set statusline +=%2*%y%*                "file type
set statusline +=%1*\ %<%F%*            "full path
set statusline +=%1*\ %*%5*%m%*                "modified flag
" set statusline +=%2*\ \[%{v:register}]
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

hi User1 guifg=#eea040 guibg=#442244
hi User2 guifg=#ff3366 guibg=#442244
hi User3 guifg=#ff66ff guibg=#442244
hi User4 guifg=#a0ee40 guibg=#442244
hi User5 guifg=#eeee40 guibg=#442244

hi ActiveWindow guibg=#17152c
hi InactiveWindow guibg=#0C0B22
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

"autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
"autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType c,cpp setlocal cindent expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType javascript,html setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

"" startify

" list most recent directories visited
" https://github.com/mhinz/vim-startify/issues/429
function! s:mru_dirs()
  " get 5 most recently used working directories
  let dirs = uniq(map(copy(v:oldfiles), 'fnamemodify(v:val, ":h")'))[:4]
  return map(dirs, '{"line": fnamemodify(v:val, ":."), "path": v:val}')
endfunction

let g:startify_lists = [
	\ { 'type': function('s:mru_dirs'),'header': ['   MRU dirs']       },
	\ { 'type': 'files',               'header': ['   MRU']            },
	\ { 'type': 'dir',                 'header': ['   MRU '. getcwd()] },
	\ { 'type': 'sessions',            'header': ['   Sessions']       },
	\ { 'type': 'bookmarks',           'header': ['   Bookmarks']      },
	\ { 'type': 'commands',            'header': ['   Commands']       },
      \ ]

let g:startify_padding_left = 10
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_autoload = 1

let  g:startify_bookmarks =  [
    \ {'c': '~/.config' },
    \ {'p': '~/Maja/Projects' },
    \ {'': '~/Maja/mss' }
    \ ]

let g:startify_commands = [
    \ {'ch':  ['Health Check', ':checkhealth']},
    \ {'ps': ['Plugins status', ':PlugStatus']},
    \ {'pu': ['Update vim plugins',':PlugUpdate | PlugUpgrade']},
    \ {'uc': ['Update coc Plugins', ':CocUpdate']},
    \ {'h':  ['Help', ':help']},
    \ ]

"" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

" show mapping on all modes with F1
nmap <F1> <plug>(fzf-maps-n)
imap <F1> <plug>(fzf-maps-i)
vmap <F1> <plug>(fzf-maps-x)

map <F3> :NERDTreeToggle <CR>
map <F2> :Startify <CR>

" Tab, Windows, and Buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
map <C-n> :vnew<CR>
nnoremap <S-h> ^
nnoremap <S-l> $
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Up> :resize +2<CR>
map <Down> :resize -2<CR>
map <Left> :vertical resize -2<CR>
map <Right> :vertical resize +2<CR>
tnoremap <Esc><Esc> <C-\><C-n>

" FZF
nnoremap <silent> <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>t :BTags<CR>
nmap <leader>/ :Rg<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gs :GFiles?<CR>
nmap <leader>sh :History/<CR>

" show mapping on all modes with F1
nmap <F1> <plug>(fzf-maps-n)
imap <F1> <plug>(fzf-maps-i)
vmap <F1> <plug>(fzf-maps-x)

" plus is add (teehee)
nnoremap <leader>d "Add
vnoremap <leader>d "Add<ESC>
" Put from register A
nnoremap <leader>p "Ap
vnoremap <leader>p "Ap
" Clear register A
vnoremap <leader>d "Add<ESC>
nnoremap <leader>c :call setreg("a", [])<CR>

" stop highlighting search results with ESC
nnoremap <silent> <ESC> :noh<CR>

" make line joins and jumps more natural
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" In insert mode, F12 to insert date and <S-F12> for a datetime
inoremap <F12> <C-r>=system("date +'\%F' \| tr '\n' ' '")<CR>
inoremap <F24> <C-r>=system("date +'\%F \%T \%Z' \| tr '\n' ' '")<CR>

" look for visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

let g:surround_{char2nr('-')} = "\1start: \1\r\2end: \2"

" paste image paths found in working directory and up to sub-sub directories
" DEPS: sxiv, xclip
map <leader>i :r !find . -maxdepth 3 -print \| file -if - \| grep "image/" \| awk -F: '{print $1}' \| xargs sxiv -qto 2> /dev/null <CR><CR>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

nnoremap <leader>ttoc :-1read $HOME/.config/nvim/.skeleton.ttoc<CR>:set filetype=asciidoc<CR>3jf>a
nnoremap <leader>html :-1read $HOME/.config/nvim/.skeleton.html<CR>:set filetype=html<CR>3jf>a
nnoremap <leader>ccp  :-1read $HOME/.config/nvim/.skeleton.cpp<CR>:set filetype=cpp<CR>3jf>a

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

let g:slime_no_mappings = 1
autocmd FileType python xmap <Space> <Plug>SlimeRegionSend
autocmd FileType python nmap <Space> <Plug>SlimeParagraphSend
nmap <C-c>v <Plug>SlimeConfig

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

"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

let g:rooter_change_directory_for_non_project_files = 'current'

