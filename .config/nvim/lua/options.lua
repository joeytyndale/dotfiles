local opt = vim.opt
local g = vim.g

-- change fillchars for folding, vertical split, end of buffer, and message separator
opt.fillchars = {
  fold = " ",
  vert = "│",
  eob = " ",
  diff = "╱"
}

-- Split window below/right when creating horizontal/vertical windows
opt.splitbelow = true
opt.splitright = true

-- avoid the flickering when splitting window horizontal
opt.splitkeep = "screen"

-- Time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 500

opt.updatetime = 500  -- For CursorHold events

-- Clipboard settings, always use clipboard for all delete, yank, change, put
-- operation
opt.clipboard:append("unnamedplus")

-- Disable creating swapfiles
opt.swapfile = false

-- Ignore certain files and folders when globing
opt.wildignore:append({
  "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
  "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**",
  "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico",
  "*.pyc", "*.pkl",
  "*.DS_Store",
  "*.aux", "*.bbl", "*.blg", "*.brf", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.xdv"
})
opt.wildignorecase = true  -- ignore file and dir name cases in cmd-completion

-- Set up backup directory
local backupdir = vim.fn.stdpath('data') .. '/backup//'
g.backupdir = backupdir
opt.backupdir = backupdir

-- Skip backup for patterns in option wildignore
opt.backupskip = opt.wildignore:get()
opt.backup = true  -- create backup for files
opt.backupcopy = "yes"  -- copy the original file to backupdir and overwrite it

-- General tab settings
opt.tabstop = 2       -- number of visual spaces per TAB
opt.softtabstop = 2   -- number of spaces in tab when editing
opt.shiftwidth = 2    -- number of spaces to use for autoindent
opt.expandtab = true  -- expand tab to spaces so that tabs are spaces

-- Set matching pairs of characters and highlight matching brackets
opt.matchpairs:append("<:>")

opt.number = true         -- Show line number
opt.relativenumber = true -- Show relative line number

-- Ignore case in general, but become case-sensitive when uppercase is present
opt.ignorecase = true
opt.smartcase = true

-- File and script encoding settings for vim
opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- Break line at predefined characters
opt.linebreak = true
-- Character to show before the lines that have been soft-wrapped
opt.showbreak = "↪"

-- List all matches and complete till longest common string
opt.wildmode = "list:longest"

-- Minimum lines to keep above and below cursor when scrolling
opt.scrolloff = 3

-- Use mouse to select and resize windows, etc.
opt.mouse = "n"
opt.mousemodel = "popup"  -- Set the behaviour of mouse
opt.mousescroll = "ver:1,hor:0"

-- Disable showing current mode on command line since statusline plugins can show it.
opt.showmode = false

opt.fileformats = { "unix", "dos" }  -- Fileformats to use for new files

-- Ask for confirmation when handling unsaved or read-only files
opt.confirm = true

opt.visualbell = true  -- Use visual bell
opt.errorbells = false -- Do not use errorbells
opt.history = 500  -- The number of command and search history to keep

-- Use list mode and customized listchars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣"
}

-- Auto-write the file based on some condition
opt.autowrite = true

-- Show hostname, full path of file and last-mod time on the window title.
opt.title = true
opt.titlestring = ""

-- Persistent undo even after you close a file and re-open it
opt.undofile = true

-- Do not show "match xx of xx" and other messages during auto-completion
opt.shortmess:append("c")

-- Do not show search match count on bottom right
opt.shortmess:append("S")

-- Disable showing intro message (:intro)
opt.shortmess:append("I")

-- Completion behaviour
opt.completeopt:append("menuone")  -- Show menu even if there is only one item
opt.completeopt:remove("preview")  -- Disable the preview window

opt.pumheight = 10  -- Maximum number of items to show in popup menu
opt.pumblend = 5    -- pseudo transparency for completion menu

opt.winblend = 0    -- pseudo transparency for floating window

-- Insert mode key word completion setting
opt.complete:append("kspell")
opt.complete:remove("w")
opt.complete:remove("b")
opt.complete:remove("u")
opt.complete:remove("t")

opt.spelllang = { "en", "cjk" }  -- Spell languages
opt.spellsuggest:append("9")     -- show 9 spell suggestions at most

-- Align indent to next multiple value of shiftwidth.
opt.shiftround = true

opt.virtualedit = "block"  -- Virtual edit is useful for visual block edit

-- Correctly break multi-byte characters such as CJK
opt.formatoptions:append("mM")

-- Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
opt.tildeop = true

opt.synmaxcol = 250  -- Text after this column number is not highlighted
opt.startofline = false

-- External program to use for grep command
if vim.fn.executable('rg') == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Enable true color support
opt.termguicolors = true

-- Set up cursor color and shape in various mode
opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"

opt.signcolumn = "yes:1"

-- Remove certain character from file name pattern matching
opt.isfname:remove("=")
opt.isfname:remove(",")

-- diff options
opt.diffopt = {
  "vertical",      -- show diff in vertical position
  "filler",        -- show filler for deleted lines
  "closeoff",      -- turn off diff when one file window is closed
  "context:3",     -- context for diff
  "internal",
  "indent-heuristic",
  "algorithm:histogram",
  "linematch:60"
}

opt.wrap = false  -- do no wrap
opt.ruler = false

-- Show command location in status line
opt.showcmdloc = "statusline"
