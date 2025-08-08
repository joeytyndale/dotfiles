-- This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
-- This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
-- Originally based on jdhao/nvim-config but adapted for personal preferences.

vim.loader.enable()

local utils = require("utils")

local expected_version = "0.11.1"
utils.is_compatible_version(expected_version)

local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

-- some global settings
require("globals")

-- setting options in nvim
require("options")

-- various autocommands
require("custom-autocmd")

-- all the user-defined mappings
require("mappings")

-- all the plugins installed and their configurations
require("plugin_specs")

-- diagnostic related config
require("diagnostic-conf")

-- colorscheme settings
local color_scheme = require("colorschemes")

-- Load a random colorscheme
color_scheme.rand_colorscheme()
