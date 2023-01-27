nnoremap <Space> <Nop>
let mapleader = " "

lua require('plugins')
lua require('lsp')
lua require('cmpsetup')
lua require('telescope')
lua require('treesitter')
lua << EOF
require('lualine').setup {
    sections = {
        lualine_c = {'filename', 'lsp_progress'}
    }
}
EOF
lua << EOF
require('neotest').setup{
  adapters = {
    require('neotest-dart'),
    require('neotest-go'),
    require('neotest-rust'),
  },
}
EOF

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set list
set listchars=tab:▸·,trail:·

set number relativenumber

set cursorline
set cursorlineopt=line

colorscheme nightfox

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Use <Esc> to switch to normal mode from terminal mode.
" If a <Esc> is needed in the terminal, <Ctrl>+<v> <Esc> can be used.
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
