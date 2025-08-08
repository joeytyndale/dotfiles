local nnoremap = require("joeytyndale.keymap").nnoremap
nnoremap("<leader>pv", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

--Fuzzy Files (Telescope)
nnoremap("<leader>ff","<cmd>Telescope find_files<CR>")
nnoremap("<C-p>","<cmd>Telescope find_files<CR>")
nnoremap("<leader>fg","<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb","<cmd>Telescope buffers<cr>")
nnoremap("<leader>s","<cmd>Telescope lsp_document_symbols<cr>")
nnoremap("<leader>gb","<cmd>Telescope git_branches<cr>")
nnoremap("<leader>gp","<cmd>G push<cr>")
nnoremap("<leader>gg","<cmd>G<cr>")
nnoremap("<leader>fh","<cmd>lua require('telescope.builtin').help_tags()<cr>")

--Movement
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

--Other
nnoremap('<leader>c', '<cmd>TagbarToggle<CR>')

--Git
nnoremap("<leader>gdg","<cmd>diffget<CR>")
nnoremap("<leader>gdp","<cmd>diffput<CR>")
nnoremap("<leader>gds","<cmd>Gdiffsplit<CR>")

--LSP (keybindings now handled in lsp.lua on_attach function)
-- Enhanced LSP symbol search commands
nnoremap("<leader>gs","<cmd>LspDocumentSymbolSearch<CR>")
nnoremap("<leader>gS","<cmd>LspWorkspaceSymbolSearch<CR>")

--PhpUnit
nnoremap("<leader>t","<cmd>TestNearest<CR>", {silent = true, buffer = false})
nnoremap("<leader>T","<cmd>TestFile<CR>")
nnoremap("<leader>l","<cmd>TestLast<CR>")
nnoremap("<leader>a","<cmd>TestSuite<CR>")

--Nerd
nnoremap("<C-n>", "<cmd>NERDTreeToggle<CR>")

--Treesitter Context
nnoremap("<leader>tc", "<cmd>TSContextToggle<CR>")

--LSP Diagnostics
nnoremap("<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
nnoremap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

--Harpoon
nnoremap("<leader>ha", "<cmd>lua require('harpoon'):list():add()<CR>")
nnoremap("<leader>hr", "<cmd>lua require('harpoon'):list():remove()<CR>")
nnoremap("<leader>hm", "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>")
nnoremap("<leader>ht", "<cmd>lua require('telescope._extensions.harpoon').marks(require('telescope.themes').get_dropdown{})<CR>")

-- Quick access to harpooned files
nnoremap("<leader>1", "<cmd>lua require('harpoon'):list():select(1)<CR>")
nnoremap("<leader>2", "<cmd>lua require('harpoon'):list():select(2)<CR>")
nnoremap("<leader>3", "<cmd>lua require('harpoon'):list():select(3)<CR>")
nnoremap("<leader>4", "<cmd>lua require('harpoon'):list():select(4)<CR>")

-- Navigate between harpooned files
nnoremap("<leader>hp", "<cmd>lua require('harpoon'):list():prev()<CR>")
nnoremap("<leader>hn", "<cmd>lua require('harpoon'):list():next()<CR>")
