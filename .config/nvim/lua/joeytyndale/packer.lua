vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    --LSP and Completion Stuff
    use 'prabirshrestha/vim-lsp'
    use 'prabirshrestha/asyncomplete.vim'
    use 'prabirshrestha/asyncomplete-lsp.vim'
    use 'mattn/vim-lsp-settings'
    use 'dmerejkowsky/vim-ale'
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    
    --TOKYOOOO
    use 'folke/tokyonight.nvim'

    --GIT
    use 'tpope/vim-fugitive'
    use 'tveskag/nvim-blame-line'

    --Fuzzyness
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use '/usr/local/opt/fzf'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mileszs/ack.vim'
    use 'BurntSushi/ripgrep'

    --Nice to have
    use 'terryma/vim-smooth-scroll'
    use 'preservim/nerdtree'
    use 'preservim/tagbar'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --Buffs
    use 'ap/vim-buftabline'

    --Moving around
    use 'christoomey/vim-tmux-navigator'

    --PHPUNIT Tests baby!!!
    use({
      'nvim-neotest/neotest',
      requires = {
        'olimorris/neotest-phpunit',
      },
      config = function()
        require('neotest').setup({
          adapters = {
            require('neotest-phpunit'),
          }
        })
      end
    })
    use 'vim-test/vim-test'

    --Style stuff
    use 'stephpy/vim-php-cs-fixer'

end)

