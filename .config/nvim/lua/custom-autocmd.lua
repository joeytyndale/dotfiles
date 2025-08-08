local api = vim.api
local utils = require("utils")

-- Create custom autocommand group
local autocmd_group = api.nvim_create_augroup("MyAutoCmd", { clear = true })

-- Auto-resize windows when terminal is resized
api.nvim_create_autocmd("VimResized", {
  group = autocmd_group,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Auto-resize windows on terminal resize",
})

-- Highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
  group = autocmd_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Remove trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  group = autocmd_group,
  callback = function()
    local save_pos = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_pos)
  end,
  desc = "Remove trailing whitespace on save",
})

-- Auto create directories when saving files
api.nvim_create_autocmd("BufWritePre", {
  group = autocmd_group,
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
})

-- Set filetype for specific files
api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = autocmd_group,
  pattern = {
    "*.toml",
    "Cargo.lock",
    "*.lock",
  },
  callback = function()
    vim.bo.filetype = "toml"
  end,
  desc = "Set filetype to toml for certain files",
})

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = autocmd_group,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check if file needs reloading when focus is gained",
})

-- Go to last position when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  group = autocmd_group,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_pos then
      return
    end
    vim.b[buf].last_pos = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last position when opening a buffer",
})

-- Close certain filetypes with <q>
api.nvim_create_autocmd("FileType", {
  group = autocmd_group,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain filetypes with q",
})

-- Auto toggle between absolute and relative line numbers
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = autocmd_group,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.o.relativenumber = true
    end
  end,
  desc = "Turn on relative line numbers",
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = autocmd_group,
  callback = function()
    if vim.o.nu then
      vim.o.relativenumber = false
    end
  end,
  desc = "Turn off relative line numbers",
})

-- Trigger InGitRepo User event if we are in a git repository
api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  group = autocmd_group,
  callback = function()
    utils.inside_git_repo()
  end,
  desc = "Trigger InGitRepo User event if in git repo",
})

-- PHP specific settings
api.nvim_create_autocmd("FileType", {
  group = autocmd_group,
  pattern = "php",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
  desc = "PHP indentation settings",
})
