local opt = vim.opt -- for conciseness
local g = vim.g

local options = {
  -- line numbers
  relativenumber = true, -- show relative line numbers
  number = true, -- shows absolute line number on cursor line (when relative number is on)
  numberwidth = 2,
  ruler = false,

  -- tabs & indentation
  tabstop = 2, -- 2 spaces for tabs (prettier default)
  shiftwidth = 2, -- 2 spaces for indent width
  expandtab = true, -- expand tab to spaces
  autoindent = true, -- copy indent from current line when starting new one
  smartindent = true, -- make indenting smarter again
  softtabstop = 2,
  -- line wrapping
  wrap = false, -- disable line wrapping

  -- search settings
  ignorecase = true, -- ignore case when searching
  smartcase = true, -- if you include mixed case in your search, assumes you want case-sensitive
  hlsearch = true,                         -- highlight all matches on previous search pattern

  -- cursor line
  cursorline = true, -- highlight the current cursor line

  -- appearance

  -- turn on termguicolors for nightfly colorscheme to work
  -- (have to use iterm2 or any other true color terminal)
  termguicolors = true,
  background = "dark", -- colorschemes that can be light or dark will be made dark
  signcolumn = "yes", -- show sign column so that text doesn't shift

  -- backspace
  backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position

  -- clipboard
  clipboard = "unnamedplus", -- use system clipboard as default register

  -- split windows
  splitright = true, -- split vertical window to the right
  splitbelow = true, -- split horizontal window to the bottom

  laststatus = 3, -- global statusline
  showmode = false, -- we don't need to see things like -- INSERT -- anymore

  -- title 
  title = true,

  fillchars = { eob = ' ' },
  mouse = "a",

  timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,

  updatetime = 250, -- interval for writing swap file to disk, also used by gitsigns

-- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file

  guifont = "monospace:h17",               -- the font used in graphical neovim applications

-- hidden = true
-- breakindent = true
}

opt.iskeyword:append("-") -- consider string-string as whole word

-- disable nvim intro
opt.shortmess:append "sI"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"


for k, v in pairs(options) do
  opt[k] = v
end

g.mapleader = " "

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
