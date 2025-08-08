local keymap = vim.keymap
local uv = vim.uv

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Turn the word under cursor to upper case
keymap.set("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
keymap.set("i", "<c-t>", "<Esc>b~lea")

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- Shortcut for faster save and quit
keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })

-- Saves the file if modified and quit
keymap.set("n", "<leader>q", "<cmd>x<cr>", { silent = true, desc = "quit current window" })

-- Quit all opened buffers
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" })

-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "close qf and location list",
})

-- Delete a buffer, without closing the window, see https://stackoverflow.com/q/4465095/6064933
keymap.set("n", [[\d]], "<cmd>bprevious <bar> bdelete #<cr>", {
  silent = true,
  desc = "delete current buffer",
})

keymap.set("n", [[\D]], function()
  local buf_ids = vim.api.nvim_list_bufs()
  local cur_buf = vim.api.nvim_win_get_buf(0)

  for _, buf_id in pairs(buf_ids) do
    -- do not Delete unlisted buffers, which may lead to unexpected errors
    if vim.api.nvim_get_option_value("buflisted", { buf = buf_id }) and buf_id ~= cur_buf then
      vim.api.nvim_buf_delete(buf_id, { force = true })
    end
  end
end, {
  desc = "delete other buffers",
})

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line below",
})

keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line above",
})

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")
keymap.set("n", "0", "g0")

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")

-- Go to start or end of line easier
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open init.lua",
})

keymap.set("n", "<leader>sv", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "reload init.lua",
})

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
  expr = true,
  desc = "reselect last pasted area",
})

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Toggle spell checking
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Copy entire buffer.
keymap.set("n", "<leader>y", "<cmd>%yank<cr>", { desc = "yank entire buffer" })

-- Move current line up and down
keymap.set("n", "<A-k>", "<cmd>move .-2<cr>==", { desc = "move line up" })
keymap.set("n", "<A-j>", "<cmd>move .+1<cr>==", { desc = "move line down" })

-- Move current visual-line selection up and down
keymap.set("x", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "move selection up" })
keymap.set("x", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "move selection down" })

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- Do not move my cursor when joining lines.
keymap.set("n", "J", function()
  vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, {
  desc = "join lines without moving cursor",
})

keymap.set("n", "gJ", function()
  -- we must use `normal!`, otherwise it will trigger recursive mapping
  vim.cmd([[
      normal! mzgJ`z
      delmarks z
    ]])
end, {
  desc = "join lines without moving cursor",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
  keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Go to beginning of command in command-line mode
keymap.set("c", "<C-A>", "<HOME>")

-- Delete the character to the right of the cursor
keymap.set("i", "<C-D>", "<DEL>")

keymap.set("n", "<leader>cb", function()
  local cnt = 0
  local blink_times = 7
  local timer = uv.new_timer()
  if timer == nil then
    return
  end

  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      vim.cmd([[
      set cursorcolumn!
      set cursorline!
    ]])

      if cnt == blink_times then
        timer:close()
      end

      cnt = cnt + 1
    end)
  )
end, { desc = "show cursor" })

------------------------------------------------------------------------
--                          FUZZY FINDING                            --
------------------------------------------------------------------------
-- Fuzzy file search
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "find files" })
keymap.set("n", "<C-p>", "<cmd>FzfLua files<CR>", { desc = "find files" })

-- Fuzzy grep 
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "live grep" })

-- Fuzzy buffer search
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" })

-- LSP document symbols
keymap.set("n", "<leader>s", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "document symbols" })

-- Git branches
keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "git branches" })

-- Help tags
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help tags" })

------------------------------------------------------------------------
--                          GIT MAPPINGS                             --
------------------------------------------------------------------------
keymap.set("n", "<leader>gp", "<cmd>G push<CR>", { desc = "git push" })
keymap.set("n", "<leader>gg", "<cmd>G<CR>", { desc = "git status" })

------------------------------------------------------------------------
--                          MOVEMENT                                  --
------------------------------------------------------------------------
-- Better search navigation - keep cursor in center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

------------------------------------------------------------------------
--                          OTHER UTILITIES                          --
------------------------------------------------------------------------
-- Tagbar toggle
keymap.set("n", "<leader>c", "<cmd>TagbarToggle<CR>", { desc = "toggle tagbar" })

-- NERDTree toggle
keymap.set("n", "<C-n>", "<cmd>NERDTreeToggle<CR>", { desc = "toggle nerdtree" })

-- Treesitter context toggle
keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<CR>", { desc = "toggle treesitter context" })

-- LSP diagnostics
keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "show diagnostic" })
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic" })
keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "diagnostic loclist" })

------------------------------------------------------------------------
--                          PHPUNIT MAPPINGS (PRESERVED)             --
------------------------------------------------------------------------
-- Test nearest
keymap.set("n", "<leader>t", "<cmd>TestNearest<CR>", { 
  silent = true, 
  desc = "run nearest test" 
})

-- Test file
keymap.set("n", "<leader>T", "<cmd>TestFile<CR>", { 
  desc = "run test file" 
})

-- Test last
keymap.set("n", "<leader>l", "<cmd>TestLast<CR>", { 
  desc = "run last test" 
})

-- Test suite
keymap.set("n", "<leader>a", "<cmd>TestSuite<CR>", { 
  desc = "run all tests" 
})

------------------------------------------------------------------------
--                          HARPOON MAPPINGS (PRESERVED)             --
------------------------------------------------------------------------
-- Add to harpoon
keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon'):list():add()<CR>", { 
  desc = "harpoon add" 
})

-- Remove from harpoon
keymap.set("n", "<leader>hr", "<cmd>lua require('harpoon'):list():remove()<CR>", { 
  desc = "harpoon remove" 
})

-- Toggle harpoon menu
keymap.set("n", "<leader>hm", "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>", { 
  desc = "harpoon menu" 
})

-- Harpoon telescope integration
keymap.set("n", "<leader>ht", "<cmd>FzfLua harpoon<CR>", { 
  desc = "harpoon telescope" 
})

-- Quick access to harpooned files
keymap.set("n", "<leader>1", "<cmd>lua require('harpoon'):list():select(1)<CR>", { desc = "harpoon 1" })
keymap.set("n", "<leader>2", "<cmd>lua require('harpoon'):list():select(2)<CR>", { desc = "harpoon 2" })
keymap.set("n", "<leader>3", "<cmd>lua require('harpoon'):list():select(3)<CR>", { desc = "harpoon 3" })
keymap.set("n", "<leader>4", "<cmd>lua require('harpoon'):list():select(4)<CR>", { desc = "harpoon 4" })

-- Navigate between harpooned files
keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon'):list():prev()<CR>", { desc = "harpoon prev" })
keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon'):list():next()<CR>", { desc = "harpoon next" })

------------------------------------------------------------------------
--                          MISC MAPPINGS                            --
------------------------------------------------------------------------
-- Fun animation
keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "make it rain" })
