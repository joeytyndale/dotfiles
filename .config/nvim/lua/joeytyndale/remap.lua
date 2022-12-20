local nnoremap = require("joeytyndale.keymap").nnoremap
nnoremap("<leader>pv", "<cmd>Ex<CR>")

--Fuzzy and files
nnoremap("<C-p>","<cmd>FZF<CR>")
nnoremap("<leader>ff","<cmd>FZF<cr>")
nnoremap("<leader>c","<cmd>TagbarToggle<CR>")
nnoremap("<leader>fg","<cmd>Ag<cr>")
nnoremap("<leader>fb","<cmd>lua require('telescope.builtin').buffers()<cr>")
nnoremap("<leader>fh","<cmd>lua require('telescope.builtin').help_tags()<cr>")

--Movement
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

--LSP
nnoremap("gd","<cmd>LspDefinition<CR>")
nnoremap("gs","<cmd>LspDocumentSymbolSearch<CR>")
nnoremap("gS","<cmd>LspWorkspaceSymbolSearch<CR>")
nnoremap("gr","<cmd>LspReferences<CR>")
nnoremap("gi","<cmd>LspImplementation<CR>")
nnoremap("gt","<cmd>LspTypeDefinition<CR>")
nnoremap("<leader>rn","<cmd>LspRename<CR>")
nnoremap("K","<cmd>LspHover<CR>")

--Git
nnoremap("<leader>gdg","<cmd>diffget<CR>")
nnoremap("<leader>gr","<cmd>diffget<CR>")
nnoremap("<leader>gdp","<cmd>diffput<CR>")
nnoremap("<leader>gk","<cmd>diffput<CR>")
nnoremap("<leader>gds","<cmd>Gdiffsplit<CR>")

--PhpUnit
nnoremap("<leader>t","<cmd>TestNearest<CR>", {silent = true, buffer = false})
nnoremap("<leader>T","<cmd>TestFile<CR>")
nnoremap("<leader>l","<cmd>TestLast<CR>")
nnoremap("<leader>a","<cmd>TestSuite<CR>")
