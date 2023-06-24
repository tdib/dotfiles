return {
    { 'nyoom-engineering/nyoom.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig', -- Required
            -- Optional
            {
                'williamboman/mason.nvim',
                build = ':MasonUpdate',
            },
            'williamboman/mason-lspconfig.nvim', -- Optional

            -- Autocompletion
            'hrsh7th/nvim-cmp',     -- Required
            'hrsh7th/cmp-nvim-lsp', -- Required
            'L3MON4D3/LuaSnip',     -- Required
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        tag = '0.1.1'
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons', -- optional
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'folke/neodev.nvim',
    },

    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup()
        end
    },

    {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        dependencies = 'neovim/nvim-lspconfig',
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
        config = function(_, opts)
            require('rust-tools').setup(opts)
        end
    },
    {
        'NvChad/base46',
        branch = 'v2.0',
        build = function()
            require('base46').load_all_highlights()
        end,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
    { 'github/copilot.vim' }
}
