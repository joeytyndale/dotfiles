--Leader!!
vim.g.mapleader = " "

--Your basic stuff
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false

--Files, swaps, undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.g.ackprg = 'ag --vimgrep'
--vim.g['test#strategy']="neovim"
--vim.g['test#php#phpunit#executable']="cd /Users/joeytyndale/Projects/shinedock && docker-compose exec workspace php artisan test"
--vim.g['test#neovim#term_position']="vert botright"
--vim.g['test#neovim#start_normal']=1
--vim.g['test#basic#start_normal']=1
