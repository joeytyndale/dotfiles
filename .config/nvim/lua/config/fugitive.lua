-- Fugitive keymaps are already set in mappings.lua
-- This file is for any fugitive-specific configuration

-- Set up some useful commands
vim.api.nvim_create_user_command("Gblame", "Git blame", {})
vim.api.nvim_create_user_command("Glog", "Git log --oneline", {})
vim.api.nvim_create_user_command("Gdiff", "Git diff", {})
