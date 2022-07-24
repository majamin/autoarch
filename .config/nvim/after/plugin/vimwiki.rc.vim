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
