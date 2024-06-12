--Leader!!
vim.g.mapleader = " "

-- Enable autoindent
vim.cmd[[filetype plugin indent on]]
vim.o.autoindent = true
vim.o.smartindent = true

--Your basic stuff
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

--Files, swaps, undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--PHPUnit test stuff
vim.g['test#strategy']="neovim_sticky"
vim.g['test#php#phpunit#executable']="cd $HOME/Projects/shinedock && docker-compose exec workspace ./vendor/bin/phpunit"
vim.g['test#neovim#term_position']="vert botright"
vim.g['test#preserve_screen'] = 0
vim.g['test#neovim_sticky#reopen_window'] = 1
vim.g['test#neovim#start_normal']=1
vim.g['test#neovim_sticky#start_normal']=1
vim.g['test#basic#start_normal']=1
