vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true })

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('lsp')
require('cmpsetup')
require('telescope')

require('lualine').setup {
    sections = {
        lualine_c = {{'filename', path=1}, 'lsp_progress'}
    }
}

require('neotest').setup{
  adapters = {
    require('neotest-dart'),
    require('neotest-go'),
    require('neotest-rust'),
  },
}

vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.opt.list = true
vim.opt.listchars = "tab:▸·,trail:·"

vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"

vim.opt.title = true

require('nightfox').setup({
  options = {
    transparent = true,
  }
})

vim.cmd "colorscheme nightfox"

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { noremap = true })

-- Use <Esc> to switch to normal mode from terminal mode.
-- If a <Esc> is needed in the terminal, <Ctrl>+<v> <Esc> can be used.
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-v><Esc>", "<Esc>", { noremap = true })

vim.api.nvim_create_autocmd({"BufEnter"}, {pattern = "github.com_*.txt", command = "set filetype=markdown"})
vim.api.nvim_create_autocmd({"BufEnter"}, {pattern = "revolution.dev_*.txt", command = "set filetype=markdown"})

vim.filetype.add( { filename = { [ 'Justfile' ] = 'just', }, } )
