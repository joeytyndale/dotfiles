-- Set colorscheme (you can change this to any of your installed themes)
-- Available: 'oxocarbon', 'dracula', 'vscode', 'catppuccin'
vim.cmd.colorscheme 'oxocarbon'

-- Optional: Enable diagnostic signs in the sign column
vim.fn.sign_define("DiagnosticSignError", {text = "●", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "●", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "●", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "●", texthl = "DiagnosticSignHint"})

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
