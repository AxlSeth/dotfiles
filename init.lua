-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: seramaro <seramaro@student.42antananarivo  +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/03/24 07:32:36 by seramaro          #+#    #+#             --
--   Updated: 2026/05/31 11:09:42 by seramaro         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- ── Runtimepath: make ~/.local/share/nvim/site visible ──────────────────────
vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

-- ── vim-be-good (native package) ────────────────────────────────────────────
pcall(vim.cmd.packadd, "vim-be-good")

-- ── Silence unused providers ────────────────────────────────────────────────
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_ruby_provider    = 0

-- ── Native treesitter highlighting (replaces nvim-treesitter) ───────────────
-- nvim-treesitter is archived as of April 2026. Neovim 0.12 has treesitter
-- built in. We enable highlighting natively for the languages we use.
vim.api.nvim_create_autocmd("FileType", {
  pattern  = { "c", "python", "lua", "bash", "regex" },
  callback = function()
    local ok, err = pcall(vim.treesitter.start)
    if not ok then
      -- silently ignore if parser not available for this filetype
      _ = err
    end
  end,
})

-- ── Telescope ───────────────────────────────────────────────────────────────
do
  local ok, telescope = pcall(require, "telescope")
  if ok then
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<CR>"]  = actions.select_default,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<CR>"]  = actions.select_default,
            ["<Esc>"] = actions.close,
            ["q"]     = actions.close,
          },
        },
      },
    })
  end
end

-- ── Colorscheme ─────────────────────────────────────────────────────────────
pcall(dofile, vim.fn.stdpath("config") .. "/lua/colors/scarlet-protocol.lua")

-- ── nvim-notify ─────────────────────────────────────────────────────────────
do
  local ok, notify = pcall(require, "notify")
  if ok then
    notify.setup({
      background_colour = "#0a0e14",
      fps              = 60,
      icons            = { DEBUG = "", ERROR = "", INFO = "", TRACE = "✎", WARN = "" },
      level            = 2,
      minimum_width    = 50,
      render           = "default",
      stages           = "fade_in_slide_out",
      timeout          = 3000,
      top_down         = true,
    })
    vim.notify = notify
  end
end

-- ── Highlight groups ─────────────────────────────────────────────────────────
do
  vim.api.nvim_set_hl(0, "SigArt",     { fg = "#8c1c1c" })
  vim.api.nvim_set_hl(0, "SigKey",     { fg = "#3d7878", bold = true })
  vim.api.nvim_set_hl(0, "SigLabel",   { fg = "#c4b8a8" })
  vim.api.nvim_set_hl(0, "SigSection", { fg = "#8c1c1c", bold = true })
  vim.api.nvim_set_hl(0, "SigNum",     { fg = "#9a7a30" })
  vim.api.nvim_set_hl(0, "SigFile",    { fg = "#9a8e80" })
  vim.api.nvim_set_hl(0, "SigFooter",  { fg = "#7a6050", italic = true })
end

-- ── Dashboard ────────────────────────────────────────────────────────────────
do
  local ART = {
    "",
    "",
    "                                                                       ",
    "                                                                     ",
    "       ████ ██████           █████      ██                     ",
    "      ███████████             █████                             ",
    "      █████████ ███████████████████ ███   ███████████   ",
    "     █████████  ███    █████████████ █████ ██████████████   ",
    "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
    "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
    " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
  }
  local MENU = {
    { key = "n", label = "New file",     cmd = "enew" },
    { key = "f", label = "Find file",    cmd = "Telescope find_files" },
    { key = "g", label = "Grep text",    cmd = "Telescope live_grep" },
    { key = "r", label = "Recent files", cmd = "Telescope oldfiles" },
  }
  local LEFT_W = 62
  local function pad(s, w)
    local dw = vim.fn.strdisplaywidth(s)
    return dw < w and (s .. string.rep(" ", w - dw)) or s
  end
  local function right_lines()
    local r             = { "", "" }
    local project_paths = {}
    local recent_paths  = {}
    for i = 1, #MENU, 2 do
      local a, b = MENU[i], MENU[i + 1]
      local row = string.format("  %s  %-18s", a.key, a.label)
      if b then row = row .. string.format("  %s  %s", b.key, b.label) end
      r[#r + 1] = row
    end
    r[#r + 1] = ""
    r[#r + 1] = "  -- け い か く ----------------------"
    r[#r + 1] = ""
    local seen, n = {}, 0
    for _, f in ipairs(vim.v.oldfiles or {}) do
      local d = vim.fn.fnamemodify(f, ":h")
      if not seen[d] and vim.fn.isdirectory(d) == 1 then
        seen[d], n = true, n + 1
        project_paths[n] = d
        r[#r + 1] = string.format("  %d  %s", n, vim.fn.fnamemodify(d, ":~"))
        if n == 5 then break end
      end
    end
    if n == 0 then r[#r + 1] = "  (none yet)" end
    r[#r + 1] = ""
    r[#r + 1] = "  -- さ い き ん ----------------------"
    r[#r + 1] = ""
    local rf = 0
    for _, f in ipairs(vim.v.oldfiles or {}) do
      if vim.fn.filereadable(f) == 1 then
        rf = rf + 1
        recent_paths[rf] = f
        r[#r + 1] = string.format("  %d  %s", rf + n, vim.fn.fnamemodify(f, ":~"))
        if rf == 5 then break end
      end
    end
    if rf == 0 then r[#r + 1] = "  (none yet)" end
    r[#r + 1] = ""
    r[#r + 1] = "  THIS GOD WON'T FORGIVE YOU."
    return r, project_paths, recent_paths, n
  end
  local ns = vim.api.nvim_create_namespace("signalis_dash")
  local function open_dashboard()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.bo[buf].buftype   = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile  = false
    local rc, project_paths, recent_paths, n = right_lines()
    local offset = math.max(0, math.floor((#ART - #rc) / 2))
    local out    = {}
    for i, art in ipairs(ART) do
      local ri = i - offset
      local r  = (ri >= 1 and ri <= #rc) and rc[ri] or ""
      out[i]   = pad(art, LEFT_W) .. "  " .. r
    end
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
    vim.bo[buf].modifiable = false
    vim.bo[buf].modified   = false
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    for i, art in ipairs(ART) do
      vim.api.nvim_buf_add_highlight(buf, ns, "SigArt", i - 1, 0, #art)
    end
    for ri, rline in ipairs(rc) do
      local li = ri + offset - 1
      if li >= 0 and li < #out then
        local col = #ART[li + 1] + 2
        if rline:match("^  %-%- ") then
          vim.api.nvim_buf_add_highlight(buf, ns, "SigSection", li, col, -1)
        elseif rline:match("THIS GOD") then
          vim.api.nvim_buf_add_highlight(buf, ns, "SigFooter", li, col, -1)
        elseif rline:match("^  %a  ") then
	   for key, label in rline:gmatch("  (%a)  ([^ ]+)") do
	    local start = rline:find("  " .. key .. "  ", 1, true)
	    if start then
	      local key_col = col + start + 1 -- position of the letter
	      vim.api.nvim_buf_add_highlight(buf, ns, "SigKey", li, key_col, key_col + 1)
	    end
	  end
        elseif rline:match("^  %d+  ") then
	  local num = rline:match("^  (%d+)  ")
	  local len = #num
	  vim.api.nvim_buf_add_highlight(buf, ns, "SigNum",  li, col + 2, col + 2 + len)
	  vim.api.nvim_buf_add_highlight(buf, ns, "SigFile", li, col + 4 + len, -1)
        end
      end
    end
    local o = { buffer = buf, silent = true, nowait = true }
    for _, m in ipairs(MENU) do
      local c = m.cmd
      vim.keymap.set("n", m.key, function() vim.cmd(c) end, o)
    end
    for i, path in ipairs(project_paths) do
      local p = path
      vim.keymap.set("n", tostring(i), function()
        vim.cmd("cd " .. vim.fn.fnameescape(p))
        vim.cmd("Telescope find_files")
      end, o)
    end
    local project_count = n
    for i, path in ipairs(recent_paths) do
      local p   = path
      local key = tostring(i + project_count)
      vim.keymap.set("n", key, function()
        vim.cmd("edit " .. vim.fn.fnameescape(p))
      end, o)
    end
    vim.keymap.set("n", "q", "<cmd>qa<cr>", o)
    local win = vim.api.nvim_get_current_win()
    vim.opt_local_number         = false
    vim.opt_local_relativenumber = false
    vim.wo[win].cursorline       = false
    vim.wo[win].signcolumn       = "no"
    vim.wo[win].wrap             = false
  end
  vim.api.nvim_create_autocmd("VimEnter", {
    once     = true,
    callback = function()
      if vim.fn.argc() == 0 then vim.schedule(open_dashboard) end
    end,
  })
end

-- ── noice.nvim ──────────────────────────────────────────────────────────────
do
  local ok, noice = pcall(require, "noice")
  if ok then
    noice.setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
      },
      presets = {
        bottom_search        = true,
        command_palette      = true,
        long_message_to_split = true,
        inc_rename           = false,
        lsp_doc_border       = false,
      },
    })
  end
end

-- ── noice + notify highlight groups ─────────────────────────────────────────
vim.api.nvim_set_hl(0, "NoiceCmdline",           { fg = "#c4b8a8", bg = "none" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",        { fg = "#8c1c1c" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",       { fg = "#c4b8a8", bg = "none" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#3d7878" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#8c1c1c" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { fg = "#9a7a30" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { fg = "#3d7878" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#3d3030" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#7a6050" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle",  { fg = "#8c1c1c" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle",   { fg = "#9a7a30" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle",   { fg = "#3d7878" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle",  { fg = "#c4b8a8" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle",  { fg = "#9a8e80" })

-- ── snacks.nvim ─────────────────────────────────────────────────────────────
do
  local ok, snacks = pcall(require, "snacks")
  if ok then
    snacks.setup({
      indent = {
        enabled = true,
        animate = { enabled = true, duration = { step = 20, total = 300 }, easing = "outQuad" },
        scope   = { enabled = true, char = "│", underline = false, only_scope = false, only_current = false },
        chunk   = { enabled = false },
      },
      scroll = {
        enabled = true,
        animate = { duration = { step = 15, total = 150 }, easing = "linear" },
      },
      scope = {
        enabled = true,
        animate = { enabled = true, duration = { step = 20, total = 200 }, easing = "outQuad" },
      },
    })
    vim.api.nvim_set_hl(0, "SnacksIndent",      { fg = "#3d1b1b" })
    vim.api.nvim_set_hl(0, "SnacksIndentScope",  { fg = "#8c1c1c", bold = true })
  end
end

-- ── nvim-autopairs ──────────────────────────────────────────────────────────
do
  local ok, ap = pcall(require, "nvim-autopairs")
  if ok then
    ap.setup({ disable_filetype = { "TelescopePrompt" } })
  end
end

-- ── 42 formatter ────────────────────────────────────────────────────────────
do
  local ok, fmt = pcall(require, "42-formatter")
  if ok then
    fmt.setup({ formatter = "c_formatter_42", filetypes = { c = true, h = true } })
    vim.keymap.set("n", "<F2>", ":CFormat42<CR>", { noremap = true, silent = true })
    pcall(vim.api.nvim_del_augroup_by_name, "C_format_42")
  end
end

-- ── 42 header ───────────────────────────────────────────────────────────────
do
  local ok, h = pcall(require, "42header")
  if ok then
    h.setup({
      default_map = true,
      auto_update = true,
      user        = "seramaro",
      mail        = "seramaro@student.42antananarivo.mg",
    })
  end
end

-- ── Diagnostics ─────────────────────────────────────────────────────────────
vim.diagnostic.config({
  underline        = true,
  virtual_text     = false,
  signs            = false,
  update_in_insert = false,
  severity_sort    = true,
})

-- ── Completion (nvim-cmp) ────────────────────────────────────────────────────
local capabilities = nil
do
  local ok_cmp, cmp = pcall(require, "cmp")
  if ok_cmp then
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        ["<C-n>"]     = cmp.mapping.select_next_item(),
        ["<C-p>"]     = cmp.mapping.select_prev_item(),
        ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      }),
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end
  local ok_caps, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok_caps then
    capabilities = cmp_lsp.default_capabilities()
  end
end

-- ── LSP: clangd (C / 42) ────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern  = { "c", "h" },
  callback = function()
    local marker   = vim.fs.find({ ".git", "compile_commands.json", ".clangd" }, { upward = true })[1]
    local root     = marker and vim.fs.dirname(marker) or vim.uv.cwd()
    vim.lsp.start({
      name         = "clangd",
      cmd          = {
        vim.fn.exepath("clangd"),
        "--query-driver=/usr/bin/clang,/usr/bin/clang++,/usr/bin/gcc,/usr/bin/g++,/usr/bin/cc",
        "--resource-dir=/usr/lib/llvm-12/lib/clang/12.0.1",
        "--background-index",
      },
      root_dir     = root,
      capabilities = capabilities,
    })
  end,
})

-- ── LSP: pyright (Python) ───────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern  = { "python" },
  callback = function()
    local marker   = vim.fs.find({ ".git", "pyproject.toml", "setup.py", "setup.cfg" }, { upward = true })[1]
    local root     = marker and vim.fs.dirname(marker) or vim.uv.cwd()
    -- Force pyright-python to use its managed Node (system node is too old).
    vim.env.PYRIGHT_PYTHON_GLOBAL_NODE = "0"
    vim.lsp.start({
      name         = "pyright",
      cmd          = { vim.fn.exepath("basedpyright-langserver"), "--stdio" },
      root_dir     = root,
      capabilities = capabilities,
      settings     = {
        python = {
          pythonPath = vim.fn.exepath("python3"),
          analysis   = {
            typeCheckingMode     = "basic",
            autoSearchPaths      = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.tabstop     = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab   = true
    vim.opt_local.autoindent  = true
    vim.opt_local.smartindent = false
    vim.opt_local.indentexpr  = ""
  end,
})

-- ── flake8 linter (Python) ──────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern  = { "python" },
  callback = function()
    vim.keymap.set("n", "<F3>", function()
      local file   = vim.fn.shellescape(vim.fn.expand("%"))
      local output = vim.fn.system("flake8 " .. file)
      vim.fn.setqflist({}, "r", { title = "flake8", lines = vim.split(output, "\n") })
      vim.cmd("copen")
    end, { buffer = true, desc = "Lint with flake8" })
  end,
})

-- ── LSP keymaps ─────────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,    opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,         opts)
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>",      vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,    opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,        opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,   opts)
  end,
})

-- ── Telescope keymaps ────────────────────────────────────────────────────────
do
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    vim.keymap.set("n", "<leader>ff", builtin.find_files,                { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,                 { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,                   { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,                 { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles,                  { desc = "Telescope recent files" })
    vim.keymap.set("n", "<leader>/",  builtin.current_buffer_fuzzy_find, { desc = "Telescope fuzzy find in buffer" })
    vim.keymap.set("n", "<leader>gf", builtin.git_files,                 { desc = "Telescope git files" })
  end
end

-- ── Terminal keymaps ─────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>th", ":split | terminal<CR>",  { desc = "Terminal horizontal" })
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal vertical" })
vim.keymap.set("n", "<leader>tt", ":tabnew | terminal<CR>", { desc = "Terminal new tab" })
vim.keymap.set("n", "<leader>tf", function()
  local buf    = vim.api.nvim_create_buf(false, true)
  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row    = math.floor((vim.o.lines - height) / 2)
  local col    = math.floor((vim.o.columns - width) / 2)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
  })
  vim.cmd("terminal")
end, { desc = "Terminal floating" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>",       { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal go left" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal go down" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal go up" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal go right" })
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal window left" })
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal window down" })
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal window up" })
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal window right" })

-- ── Window navigation ────────────────────────────────────────────────────────
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Window right" })

-- ── UI options ───────────────────────────────────────────────────────────────
vim.opt.cursorline      = true
vim.opt.number          = true
vim.opt.relativenumber  = true

vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#1a1f2e" })
vim.api.nvim_set_hl(0, "Normal",       { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",     { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn",   { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer",  { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine",   { bg = "none", fg = "#c4b8a8" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#3d1b1b" })

vim.keymap.set("n", "<leader>lh", ":set cursorline!<CR>", { desc = "Toggle cursor line" })
vim.keymap.set({ "n", "v", "x" }, ";", ":", { desc = "Enter command mode" })

-- ── Python indentation fix ───────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "python",
  callback = function()
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.tabstop     = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab   = true
    vim.opt_local.autoindent  = true
    vim.opt_local.smartindent = false
  end,
})
