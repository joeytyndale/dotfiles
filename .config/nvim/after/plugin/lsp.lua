-- Setup Mason first
require('mason').setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('mason-lspconfig').setup()

-- Enhanced LSP capabilities with better performance
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Optimize capabilities for better performance
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

-- LSP diagnostic configuration for better performance
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- Don't update diagnostics in insert mode for performance
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Define on_attach function with optimized keybindings
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  -- Essential LSP keybindings (using Telescope for consistency with leader prefix)
  vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', bufopts)
  vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', bufopts)
  vim.keymap.set('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', bufopts)
  vim.keymap.set('n', '<leader>gt', '<cmd>Telescope lsp_type_definitions<CR>', bufopts)
  
  -- Hover and signature help
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  
  -- Code actions and rename
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  
  -- Other useful LSP functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  
  -- Workspace management
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  
  -- Formatting with async for better performance
  vim.keymap.set('n', '<leader>f', function() 
    vim.lsp.buf.format({ async = true, timeout_ms = 2000 })
  end, bufopts)
  
  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
  
  -- Disable semantic highlighting for better performance (optional)
  -- client.server_capabilities.semanticTokensProvider = nil
end

-- Enhanced server configurations
local servers = {
  intelephense = {
    filetypes = { 'php' },
    settings = {
      intelephense = {
        files = {
          maxSize = 2000000, -- Increased for better large file support
          associations = {"*.php", "*.phtml", "*.inc"},
          exclude = {
            "**/node_modules/**",
            "**/vendor/**/test*/**",
            "**/vendor/**/Test*/**",
            "**/vendor/**/tests/**",
            "**/vendor/**/Tests/**",
          },
        },
        environment = {
          includePaths = { "vendor", "app" },
        },
        diagnostics = {
          enable = true,
        },
        format = {
          enable = true,
        },
        completion = {
          insertUseDeclaration = true,
          fullyQualifyGlobalConstantsAndFunctions = false,
          triggerParameterHints = true,
          maxItems = 100,
        },
      },
    },
    init_options = {
      licenceKey = vim.env.INTELEPHENSE_LICENCE_KEY or "",
    }
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { 
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' }, -- Reduce noise
        },
        completion = {
          callSnippet = "Replace"
        },
      },
    },
  },

  -- Add more language servers as needed
  -- tsserver = {
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = 'all',
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       }
  --     }
  --   }
  -- },
}

-- Setup neodev for enhanced Lua development
require('neodev').setup({
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
})

-- Ensure servers are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
})

-- Setup LSP servers with enhanced configuration (with fallback for older mason-lspconfig versions)
local function setup_server(server_name)
  local server_config = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150, -- Reduce LSP chatter
    }
  }
  
  -- Apply server-specific settings
  if servers[server_name] then
    server_config.settings = servers[server_name].settings
    server_config.filetypes = servers[server_name].filetypes
    server_config.init_options = servers[server_name].init_options
  end
  
  require('lspconfig')[server_name].setup(server_config)
end

-- Try to use setup_handlers if available (newer versions)
local setup_handlers_ok = pcall(function()
  mason_lspconfig.setup_handlers({
    function(server_name)
      setup_server(server_name)
    end,
  })
end)

-- Fallback for older versions - manually setup each server
if not setup_handlers_ok then
  for server_name, _ in pairs(servers) do
    setup_server(server_name)
  end
  
  -- Also setup any other LSP servers that mason might install
  local installed_servers = mason_lspconfig.get_installed_servers()
  for _, server_name in ipairs(installed_servers) do
    if not servers[server_name] then
      setup_server(server_name)
    end
  end
end

-- Enhanced nvim-cmp configuration
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load snippets from VSCode extensions
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      -- Set a name for each source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip', priority = 750 },
    { name = 'path', priority = 250 },
  }, {
    { name = 'buffer', priority = 250 },
  }),
  performance = {
    debounce = 60,
    throttle = 30,
    fetching_timeout = 500,
  },
})

-- LSP signs for diagnostics
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
