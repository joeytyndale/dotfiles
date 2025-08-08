-- Configure colorscheme with fallback support
local function safe_colorscheme(name, config_func)
    local ok, _ = pcall(require, name)
    if ok then
        if config_func then
            config_func()
        end
        vim.cmd.colorscheme(name)
        return true
    end
    return false
end

-- Try to load Kanagawa first (sick modern theme!)
local kanagawa_setup = function()
    require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            local theme = colors.theme
            return {
                -- More transparent floating windows
                NormalFloat = { bg = "none" },
                FloatBorder = { bg = "none" },
                FloatTitle = { bg = "none" },

                -- Save an hlgroup with dark background and dimmed foreground
                -- so that you can use it where your still want darker windows.
                -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                -- Popular plugins that open floats will link to NormalFloat by default;
                -- set their background accordingly if you wish to keep them dark and borderless
                LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                -- Telescope theme
                TelescopeTitle = { fg = theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            }
        end,
        theme = "wave",              -- Load "wave" theme when 'background' option is not set
        background = {               -- map the value of 'background' option to a theme
            dark = "wave",           -- try "dragon" !
            light = "lotus"
        },
    })
end

-- Try colorschemes in order of preference with fallbacks
if not safe_colorscheme('kanagawa', kanagawa_setup) then
    if not safe_colorscheme('catppuccin-mocha') then
        if not safe_colorscheme('oxocarbon') then
            if not safe_colorscheme('dracula') then
                -- Ultimate fallback to default
                vim.cmd.colorscheme('default')
            end
        end
    end
end

-- Alternative themes you can try by changing the line above:
-- vim.cmd.colorscheme 'tokyonight-night'        -- Dark, vibrant
-- vim.cmd.colorscheme 'rose-pine'               -- Elegant, muted
-- vim.cmd.colorscheme 'gruvbox-material'        -- Warm, retro
-- vim.cmd.colorscheme 'catppuccin-mocha'        -- Pastel, cozy
-- vim.cmd.colorscheme 'nord'                    -- Cool, arctic
-- vim.cmd.colorscheme 'onedark'                 -- VS Code style
-- vim.cmd.colorscheme 'nightfox'                -- Vibrant, modern
-- vim.cmd.colorscheme 'material'                -- Google Material
-- vim.cmd.colorscheme 'github_dark'             -- GitHub style
-- vim.cmd.colorscheme 'poimandres'              -- Unique, atmospheric

-- Configure other colorschemes (uncomment to use)
--[[
-- Tokyo Night configuration
require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
})

-- Rose Pine configuration  
require('rose-pine').setup({
    variant = 'auto', -- auto, main, moon, or dawn
    dark_variant = 'main', -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },
})

-- Catppuccin configuration
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
})
--]]

-- Custom highlight adjustments (uncomment and modify as needed)
--[[
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--]]
