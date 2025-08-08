-- Configure Telescope with optimized settings
local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    -- Visual settings
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    
    -- File settings
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { 
      "node_modules", 
      "vendor/*/test*", 
      "vendor/*/Test*",
      ".git/",
      "*.lock"
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    
    -- UI settings
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ["COLORTERM"] = "truecolor" },
    
    -- Mappings
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-/>"] = actions.which_key,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
      },
    },
  },
  
  pickers = {
    -- File pickers
    find_files = {
      theme = "dropdown",
      previewer = false,
      hidden = false,
    },
    live_grep = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    
    -- LSP pickers with enhanced settings
    lsp_references = {
      theme = "ivy",
      initial_mode = "normal",
      layout_config = {
        height = 0.4,
      },
    },
    lsp_definitions = {
      theme = "cursor",
      initial_mode = "normal",
    },
    lsp_declarations = {
      theme = "cursor",
      initial_mode = "normal",
    },
    lsp_implementations = {
      theme = "ivy",
      initial_mode = "normal",
    },
    lsp_type_definitions = {
      theme = "cursor",
      initial_mode = "normal",
    },
    lsp_document_symbols = {
      theme = "dropdown",
      previewer = false,
    },
    lsp_workspace_symbols = {
      theme = "dropdown",
    },
    diagnostics = {
      theme = "ivy",
      initial_mode = "normal",
    },
    
    -- Git pickers
    git_branches = {
      theme = "dropdown",
      previewer = false,
    },
    git_commits = {
      theme = "ivy",
    },
    git_bcommits = {
      theme = "ivy",
    },
    
    -- Other pickers
    help_tags = {
      theme = "ivy",
    },
    man_pages = {
      theme = "ivy",
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load extensions with error handling
pcall(function()
  telescope.load_extension('fzf')
end)

-- Custom functions for better LSP integration
local M = {}

-- Enhanced LSP document symbols with better formatting
M.lsp_document_symbols = function()
  require('telescope.builtin').lsp_document_symbols({
    symbol_width = 50,
    symbol_type_width = 20,
    fname_width = 30,
  })
end

-- Enhanced LSP workspace symbols with better filtering
M.lsp_workspace_symbols = function()
  require('telescope.builtin').lsp_workspace_symbols({
    query = vim.fn.input("Query: "),
  })
end

-- Setup global commands for easy access
vim.api.nvim_create_user_command('LspDocumentSymbolSearch', M.lsp_document_symbols, {})
vim.api.nvim_create_user_command('LspWorkspaceSymbolSearch', M.lsp_workspace_symbols, {})

return M
