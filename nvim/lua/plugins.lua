vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- lsp-config
  use 'neovim/nvim-lspconfig'

  -- Theme Nightfox
  use 'EdenEast/nightfox.nvim'

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- lualine-lsp-progress
  use 'arkav/lualine-lsp-progress'

  -- nvim-cmp
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"}) -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

  -- apply .editorconfig
  use 'gpanders/editorconfig.nvim'

  -- nvim-dap
  use 'mfussenegger/nvim-dap'

  -- nvim-neotest
  use {
      'nvim-neotest/neotest',
      requires = {
          'nvim-lua/plenary.nvim',
          'nvim-treesitter/nvim-treesitter',
          'antoinemadec/FixCursorHold.nvim',
          'sidlatau/neotest-dart',
          'nvim-neotest/neotest-go',
          'rouge8/neotest-rust'
      }
  }

  -- firenvim
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
  }
end)
