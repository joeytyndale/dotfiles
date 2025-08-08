require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
    "javascript", "typescript", "html", "css", "json", "yaml", "toml",
    "php", "python", "rust", "go", "bash", "dockerfile"
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},

  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    }
  },

  indent = {
    enable = true
  },

  -- matchup integration
  matchup = {
    enable = true,
  },
}

-- Set folding method to use treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default
