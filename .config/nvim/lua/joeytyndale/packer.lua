-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'eandrju/cellular-automaton.nvim'

    --Startup
    use {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup()
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    --use {
    --    "startup-nvim/startup.nvim",
    --    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    --    config = function()
    --        require("startup").setup({theme = "evil"})
    --    end
    --}

    --LSP
    use 'prabirshrestha/vim-lsp'
    use 'mattn/vim-lsp-settings'
    use { 'neovim/nvim-lspconfig',
        requires = {
          -- Automatically install LSPs to stdpath for neovim
          'williamboman/mason.nvim',
          'williamboman/mason-lspconfig.nvim',

          -- Useful status updates for LSP
          -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
          { 'j-hui/fidget.nvim', opts = {} },

          -- Additional lua configuration, makes nvim stuff amazing!
          'folke/neodev.nvim',
        },
    }
    use 'prabirshrestha/asyncomplete.vim'
    use 'prabirshrestha/asyncomplete-lsp.vim'
    use 'sbdchd/neoformat'
    use 'williamboman/mason.nvim'
    use { 'hrsh7th/nvim-cmp',
        requires = {
          -- Snippet Engine & its associated nvim-cmp source
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',

          -- Adds LSP completion capabilities
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-path',

          -- Adds a number of user-friendly snippets
          'rafamadriz/friendly-snippets',
        },
    }
    use 'adalessa/laravel.nvim'

    --FORMATTER
    --use 'stephpy/vim-php-cs-fixer'

    --FUZZY FILES
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mileszs/ack.vim'
    use 'BurntSushi/ripgrep'
    use { 'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                  return vim.fn.executable 'make' == 1
                end,
            },
        },
    }

    --General Utils
    use 'preservim/tagbar'
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'ryanoasis/vim-devicons'
    use 'PhilRunninger/nerdtree-buffer-ops'
    use 'PhilRunninger/nerdtree-visual-selection'

    use 'vimwiki/vimwiki'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    --Git
    use 'tpope/vim-fugitive'
    use 'tveskag/nvim-blame-line'

    --Moving around
    use 'christoomey/vim-tmux-navigator'
    use 'karb94/neoscroll.nvim'

    --COLOR
    use {'nyoom-engineering/oxocarbon.nvim'}
    use {'dracula/vim', as = 'dracula'}
    use 'Mofiqul/vscode.nvim'

    use { "catppuccin/nvim", as = "catppuccin"}

    --use {
    --    'daltonmenezes/aura-theme',
    --    rtp = 'packages/neovim',
    --    config = function()
    --        vim.cmd("colorscheme aura-soft-dark") -- Or any Aura theme available
    --    end
    --}

    --PHPUNIT Tests baby!!!
    use 'vim-test/vim-test'
    use({ 'nvim-neotest/neotest',
        requires = {
            'olimorris/neotest-phpunit',
            'nvim-lua/plenary.nvim',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-phpunit'),
                }
            })
        end
    })
end)
