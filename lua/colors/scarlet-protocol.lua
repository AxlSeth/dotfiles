local colors = {
  bg           = "#000000",
  bg_alt       = "#08080c",
  bg_highlight = "#1a1012",

  fg           = "#e8d5d3",
  fg_alt       = "#706870",

  bone         = "#e8d5d3",
  bone_bright  = "#f4ece8",

  steel        = "#b2adb4",
  steel_dim    = "#8a8590",

  ash          = "#9a9298",
  ash_dim      = "#706870",

  sand         = "#f8e8a0",
  sand_dim     = "#d8c870",

  parchment    = "#f2ecbc",
  parchment_dim= "#b8b28a",

  sage         = "#8890a0",
  sage_dim     = "#606878",

  silver       = "#e8d5d3",
  silver_dim   = "#cfc8cc",

  error_red    = "#9e2224",
  error_red_dim= "#6e181a",

  void         = "#362022",
  deep_void    = "#1a1012",

  comment      = "#504848",
  line_nr      = "#5a4848",
  selection    = "#3a1820",
  cursor_line  = "#140a0c",
}

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'scarlet-protocol'

local function hi(group, opts)
  local cmd = 'highlight ' .. group
  if opts.fg  then cmd = cmd .. ' guifg=' .. opts.fg  end
  if opts.bg  then cmd = cmd .. ' guibg=' .. opts.bg  end
  if opts.gui then cmd = cmd .. ' gui='   .. opts.gui  end
  if opts.sp  then cmd = cmd .. ' guisp=' .. opts.sp   end
  vim.cmd(cmd)
end

-- ── editor ui ────────────────────────────────────────────────────────────────
hi('normal',        { fg = colors.bone,        bg = colors.bg })
hi('normalfloat',   { fg = colors.bone,        bg = colors.bg_alt })
hi('normalnc',      { fg = colors.fg_alt,      bg = colors.bg })
hi('cursorline',    { bg = colors.cursor_line })
hi('cursorlinenr',  { fg = colors.steel,       gui = 'bold' })
hi('linenr',        { fg = colors.line_nr })
hi('signcolumn',    { bg = colors.bg })
hi('visual',        { bg = colors.selection })
hi('visualnos',     { bg = colors.selection })
hi('search',        { fg = colors.bg,          bg = colors.parchment })
hi('incsearch',     { fg = colors.bg,          bg = colors.steel })
hi('pmenu',         { fg = colors.bone,        bg = colors.bg_alt })
hi('pmenusel',      { fg = colors.bg,          bg = colors.steel_dim })
hi('pmenusbar',     { bg = colors.bg_highlight })
hi('pmenuthumb',    { bg = colors.steel })
hi('statusline',    { fg = colors.steel,       bg = colors.bg_highlight })
hi('statuslinenc',  { fg = colors.fg_alt,      bg = colors.bg_alt })
hi('vertsplit',     { fg = colors.void })
hi('winseparator',  { fg = colors.void })
hi('tabline',       { fg = colors.fg_alt,      bg = colors.bg_alt })
hi('tablinefill',   { bg = colors.bg })
hi('tablinesel',    { fg = colors.steel,       bg = colors.bg, gui = 'bold' })
hi('endofbuffer',   { fg = colors.line_nr })
hi('folded',        { fg = colors.void,        bg = colors.bg_highlight })
hi('foldcolumn',    { fg = colors.line_nr })
hi('matchparen',    { fg = colors.steel,       gui = 'bold,underline' })

-- ── syntax — base groups ─────────────────────────────────────────────────────
hi('comment',       { fg = colors.comment,     gui = 'italic' })

-- keywords / control flow → electric steel blue
hi('statement',     { fg = colors.steel_dim })
hi('conditional',   { fg = colors.steel_dim,   gui = 'bold' })
hi('repeat',        { fg = colors.steel_dim,   gui = 'bold' })
hi('label',         { fg = colors.steel_dim })
hi('keyword',       { fg = colors.steel_dim,   gui = 'bold' })
hi('exception',     { fg = colors.error_red })
hi('operator',      { fg = colors.ash })

-- types / storage → vivid violet
hi('type',          { fg = colors.ash })
hi('storageclass',  { fg = colors.ash_dim })
hi('structure',     { fg = colors.ash })
hi('typedef',       { fg = colors.ash })

-- identifiers / functions → bright aqua
hi('identifier',    { fg = colors.silver })
hi('function',      { fg = colors.sand, gui = 'bold' })

-- literals
hi('constant',      { fg = colors.parchment })
hi('string',        { fg = colors.sage })
hi('character',     { fg = colors.sage })
hi('number',        { fg = colors.parchment_dim })
hi('boolean',       { fg = colors.steel })
hi('float',         { fg = colors.parchment_dim })

-- preprocessor → warm gold
hi('preproc',       { fg = colors.parchment })
hi('include',       { fg = colors.steel_dim })
hi('define',        { fg = colors.parchment_dim })
hi('macro',         { fg = colors.parchment })
hi('precondit',     { fg = colors.parchment_dim })

-- specials
hi('special',       { fg = colors.ash })
hi('specialchar',   { fg = colors.ash_dim })
hi('tag',           { fg = colors.steel })
hi('delimiter',     { fg = colors.fg_alt })
hi('specialcomment',{ fg = colors.void,        gui = 'italic' })
hi('debug',         { fg = colors.error_red })

-- messages / errors
hi('error',         { fg = colors.error_red, gui = 'bold' })
hi('errormsg',      { fg = colors.error_red, bg = colors.bg })
hi('warningmsg',    { fg = colors.parchment })
hi('todo',          { fg = colors.steel,       bg = colors.bg, gui = 'bold' })

-- ── diagnostics ──────────────────────────────────────────────────────────────
hi('diagnosticerror', { fg = colors.error_red })
hi('diagnosticwarn',  { fg = colors.parchment })
hi('diagnosticinfo',  { fg = colors.steel })
hi('diagnostichint',  { fg = colors.sage_dim })

-- ── treesitter — c ───────────────────────────────────────────────────────────
hi('@keyword.c',              { fg = colors.steel_dim,    gui = 'bold' })
hi('@keyword.return.c',       { fg = colors.steel,        gui = 'bold' })
hi('@keyword.function.c',     { fg = colors.steel_dim })
hi('@type.c',                 { fg = colors.ash })
hi('@type.builtin.c',         { fg = colors.ash_dim })
hi('@function.c',             { fg = colors.sand, gui = 'bold' })
hi('@function.builtin.c',     { fg = colors.sand })
hi('@variable.c',             { fg = colors.bone })
hi('@variable.builtin.c',     { fg = colors.ash })
hi('@constant.c',             { fg = colors.parchment })
hi('@constant.builtin.c',     { fg = colors.parchment_dim })
hi('@string.c',               { fg = colors.sage })
hi('@number.c',               { fg = colors.parchment_dim })
hi('@boolean.c',              { fg = colors.steel })
hi('@operator.c',             { fg = colors.ash })
hi('@punctuation.bracket.c',  { fg = colors.fg_alt })
hi('@punctuation.delimiter.c',{ fg = colors.fg_alt })
hi('@comment.c',              { fg = colors.comment,      gui = 'italic' })
hi('@include.c',              { fg = colors.steel_dim })
hi('@preproc.c',              { fg = colors.parchment })
hi('@define.c',               { fg = colors.parchment_dim })
hi('@storageclass.c',         { fg = colors.ash_dim })
-- ── treesitter — python ──────────────────────────────────────────────────────
hi('@keyword.python',              { fg = colors.steel_dim,  gui = 'bold' })
hi('@keyword.return.python',       { fg = colors.steel,      gui = 'bold' })
hi('@keyword.function.python',     { fg = colors.steel_dim })
hi('@keyword.import.python',       { fg = colors.steel_dim })
hi('@type.python',                 { fg = colors.silver })
hi('@type.builtin.python',         { fg = colors.ash_dim })
hi('@function.python',             { fg = colors.sand, gui = 'bold' })
hi('@function.builtin.python',     { fg = colors.sand })
hi('@function.call.python',        { fg = colors.sand })
hi('@method.python',               { fg = colors.sand })
hi('@method.call.python',          { fg = colors.sand })
hi('@variable.python',             { fg = colors.silver })
hi('@variable.builtin.python',     { fg = colors.ash })
hi('@variable.parameter.python',   { fg = colors.parchment })
hi('@constant.python',             { fg = colors.parchment })
hi('@constant.builtin.python',     { fg = colors.parchment_dim })
hi('@string.python',               { fg = colors.sage })
hi('@string.documentation.python', { fg = colors.sage_dim,   gui = 'italic' })
hi('@number.python',               { fg = colors.parchment_dim })
hi('@boolean.python',              { fg = colors.steel })
hi('@operator.python',             { fg = colors.ash })
hi('@punctuation.bracket.python',  { fg = colors.fg_alt })
hi('@punctuation.delimiter.python',{ fg = colors.fg_alt })
hi('@comment.python',              { fg = colors.comment,    gui = 'italic' })
hi('@decorator.python',            { fg = colors.parchment,  gui = 'italic' })
hi('@exception.python',            { fg = colors.silver })
hi('@field.python',                { fg = colors.silver })
hi('@property.python',             { fg = colors.silver_dim })
hi('@constructor.python',          { fg = colors.silver })
hi('@lsp.type.class.python',       { fg = colors.silver })
hi('@lsp.type.function.python',    { fg = colors.sand, gui = 'bold' })
hi('@lsp.typemod.function.defaultLibrary.python', { fg = colors.sand })
hi('@lsp.type.method.python',      { fg = colors.sand })
hi('@lsp.type.property.python',    { fg = colors.silver_dim })
hi('@lsp.type.variable.python',    { fg = colors.silver })
hi('@lsp.type.parameter.python',   { fg = colors.parchment })
hi('@lsp.type.type.python',        { fg = colors.silver })
hi('@lsp.type.typeParameter.python', { fg = colors.silver })
hi('@lsp.type.keyword.python',     { fg = colors.steel_dim,  gui = 'bold' })
hi('@lsp.type.decorator.python',   { fg = colors.parchment,  gui = 'italic' })
hi('@lsp.type.operator.python',    { fg = colors.ash })
hi('@lsp.type.string.python',      { fg = colors.sage })
hi('@lsp.type.number.python',      { fg = colors.parchment_dim })
hi('@lsp.type.comment.python',     { fg = colors.comment,    gui = 'italic' })
hi('@lsp.typemod.type.defaultLibrary.python', { fg = colors.ash_dim })
hi('@lsp.typemod.class.defaultLibrary.python', { fg = colors.ash_dim })
hi('@lsp.typemod.method.defaultLibrary.python', { fg = colors.sand })
hi('@lsp.typemod.variable.defaultLibrary.python', { fg = colors.ash })
hi('@lsp.typemod.property.defaultLibrary.python', { fg = colors.silver_dim })
hi('@lsp.typemod.variable.readonly.python', { fg = colors.parchment })
