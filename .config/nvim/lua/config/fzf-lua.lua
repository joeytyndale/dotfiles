local fzf = require('fzf-lua')

fzf.setup({
  -- global options
  global_resume = true,
  global_resume_query = true,
  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = 'rounded',
    fullscreen = false,
    preview = {
      border = 'border',
      wrap = 'nowrap',
      hidden = 'nohidden',
      vertical = 'down:45%',
      horizontal = 'right:60%',
      layout = 'flex',
      flip_columns = 120,
    },
  },
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
      ["<S-left>"] = "preview-page-reset",
    },
    fzf = {
      ["ctrl-z"] = "abort",
      ["ctrl-u"] = "unix-line-discard",
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["alt-a"] = "select-all",
      ["alt-d"] = "deselect-all",
    },
  },
  previewers = {
    cat = {
      cmd = "cat",
      args = "--number",
    },
    bat = {
      cmd = "bat",
      args = "--color=always --style=numbers,changes",
      theme = 'Coldark-Dark', -- bat preview theme
    },
    head = {
      cmd = "head",
      args = nil,
    },
    git_diff = {
      pager = "delta --width=$COLUMNS --hunk-header-style='file line-number syntax'",
    },
  },
  files = {
    prompt = 'Files❯ ',
    multiprocess = true,           -- run command in a separate process
    git_icons = true,              -- show git icons?
    file_icons = true,             -- show file icons?
    color_icons = true,            -- colorize file icons
    find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
    fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
  },
  git = {
    files = {
      prompt = 'GitFiles❯ ',
      cmd = 'git ls-files --exclude-standard',
      multiprocess = true,
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
    status = {
      prompt = 'GitStatus❯ ',
      cmd = "git status -s",
      file_icons = true,
      git_icons = true,
      color_icons = true,
    },
    commits = {
      prompt = 'Commits❯ ',
      cmd = "git log --color=always --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
      preview = "git show --color=always {1}",
    },
    bcommits = {
      prompt = 'BCommits❯ ',
      cmd = "git log --color=always --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
      preview = "git show --color=always {1} -- <file>",
    },
    branches = {
      prompt = 'Branches❯ ',
      cmd = "git branch --all --color=always",
      preview = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' {1}",
    },
  },
  grep = {
    prompt = 'Rg❯ ',
    input_prompt = 'Grep For❯ ',
    multiprocess = true,
    git_icons = true,
    file_icons = true,
    color_icons = true,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
    grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
  },
  args = {
    prompt = 'Args❯ ',
    files_only = true,
  },
  oldfiles = {
    prompt = 'History❯ ',
    cwd_only = false,
    stat_file = true,              -- verify files exist on disk
  },
  buffers = {
    prompt = 'Buffers❯ ',
    file_icons = true,             -- show file icons?
    color_icons = true,            -- colorize file icons
    sort_lastused = true,          -- sort buffers() by last used
  },
  lines = {
    prompt = 'Lines❯ ',
    show_unlisted = false,         -- exclude 'help' buffers
    no_term_buffers = true,        -- exclude 'terminal' buffers
  },
  blines = {
    prompt = 'BLines❯ ',
    show_unlisted = true,          -- include 'help' buffers
    no_term_buffers = false,       -- include 'terminal' buffers
  },
  lsp = {
    prompt_postfix = '❯ ',         -- will be appended to the LSP label
    cwd_only = false,              -- LSP/diagnostics for cwd only?
    async_or_timeout = 5000,       -- timeout(ms) or 'true' for async calls
    file_icons = true,
    git_icons = false,
    color_icons = true,
  },
  diagnostics = {
    prompt = 'Diagnostics❯ ',
    cwd_only = false,
    file_icons = true,
    git_icons = false,
    color_icons = true,
    diag_icons = true,
  },
})
