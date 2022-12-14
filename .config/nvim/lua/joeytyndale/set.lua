vim.opt.guicursor = ""

vim.opt.shell = "/bin/bash"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.g.mapleader = " "

vim.g.hidden = true

vim.api.nvim_create_autocmd("BufEnter", { command = "EnableBlameLine" })
vim.g.ackprg = 'ag --vimgrep'

vim.g['test#strategy']="neovim"
vim.g['test#php#phpunit#executable']="cd /Users/joeytyndale/Projects/shinedock && docker-compose exec workspace php artisan test"
vim.g['test#neovim#term_position']="vert botright"
vim.g['test#neovim#start_normal']=1
vim.g['test#basic#start_normal']=1

vim.g.php_cs_fixer_path = '~/.composer/vendor/bin/php-cs-fixer'
