local nnoremap = require("joeytyndale.keymap").nnoremap
nnoremap("<leader>pv", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

--Fuzzy Files
nnoremap("<leader>ff","<cmd>FZF<CR>")
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

--LSP
nnoremap("gd", "<cmd>Telescope lsp_definitions<CR>")
nnoremap("<leader>gr","<cmd>Telescope lsp_references<CR>")
nnoremap("gs","<cmd>LspDocumentSymbolSearch<CR>")
nnoremap("gS","<cmd>LspWorkspaceSymbolSearch<CR>")
nnoremap("gi","<cmd>LspImplementation<CR>")
nnoremap("gt","<cmd>LspTypeDefinition<CR>")
nnoremap("<leader>rn","<cmd>LspRename<CR>")
nnoremap("K","<cmd>LspHover<CR>")

--PhpUnit
nnoremap("<leader>t","<cmd>TestNearest<CR>", {silent = true, buffer = false})
nnoremap("<leader>T","<cmd>TestFile<CR>")
nnoremap("<leader>l","<cmd>TestLast<CR>")
nnoremap("<leader>a","<cmd>TestSuite<CR>")

--Nerd
nnoremap("<C-n>", "<cmd>NERDTreeToggle<CR>")
