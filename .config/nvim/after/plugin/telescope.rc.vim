if !exists('g:loaded_telescope') | finish | endif

nnoremap <nowait> <silent> ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <nowait> <silent> fw <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <nowait> <silent> fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <nowait> <silent> fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <nowait> <silent> fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <nowait> <silent> fk <cmd>lua require('telescope.builtin').keymaps()<cr>
"nnoremap <nowait> <silent> ;; <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <nowait> <silent> fe <cmd>lua require('telescope.builtin').diagnostics()<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')
local file_browser = require("telescope").load_extension "file_browser"

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF


