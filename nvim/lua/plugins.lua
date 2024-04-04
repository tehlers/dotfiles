require('lazy').setup({
    -- Telescope
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter', 
        build = ':TSUpdate',
        config = function () 
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = { 'c', 'lua', 'rust', 'go', 'java', 'kotlin', 'dart', 'python' },
                sync_install = false,
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },  
            })
        end
    },

    -- lsp-config
    'neovim/nvim-lspconfig',

    
    -- Theme Nightfox
    'EdenEast/nightfox.nvim',

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- lualine-lsp-progress
    'arkav/lualine-lsp-progress',

    -- nvim-cmp
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
	    'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
    	}
    },

    -- apply .editorconfig
    'gpanders/editorconfig.nvim',

    -- nvim-dap
    'mfussenegger/nvim-dap',

    -- nvim-neotest
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/neotest-go',
	    'sidlatau/neotest-dart',
            'rouge8/neotest-rust'
        }
    },

    -- firenvim
    {
        'glacambre/firenvim',

        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        lazy = not vim.g.started_by_firenvim,
        build = function()
            vim.fn["firenvim#install"](0)
        end
    },
})
