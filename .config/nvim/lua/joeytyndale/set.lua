--Leader!!
vim.g.mapleader = " "

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
vim.g['test#strategy']="neovim"
vim.g['test#php#phpunit#executable']="cd /Users/joeytyndale/Projects/shinedock && docker-compose exec workspace php artisan test"
vim.g['test#neovim#term_position']="vert botright"
vim.g['test#neovim#start_normal']=1
vim.g['test#basic#start_normal']=1
