-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
  
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'eandrju/cellular-automaton.nvim'
  
    --LSP
    use 'prabirshrestha/vim-lsp'
    use 'mattn/vim-lsp-settings'
    use 'prabirshrestha/asyncomplete.vim'
    use 'prabirshrestha/asyncomplete-lsp.vim'
  
    --FUZZY FILES
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mileszs/ack.vim'
    use 'BurntSushi/ripgrep'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --General Utils
    use 'preservim/tagbar'
    use 'vimwiki/vimwiki'
    use 'nvim-treesitter/nvim-treesitter'
  
    --Git
    use 'tpope/vim-fugitive'
    
    --Moving around
    use 'christoomey/vim-tmux-navigator'
  
    --COLOR
    use {'nyoom-engineering/oxocarbon.nvim'}
    use {'dracula/vim', as = 'dracula'}
  
    --PHPUNIT Tests baby!!!
    use({
      'nvim-neotest/neotest',
      requires = {
        'olimorris/neotest-phpunit',
	'nvim-lua/plenary.nvim'
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
end)
