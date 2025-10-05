require "nvchad.options"

local o = vim.o
local g = vim.g

-- Better editing experience
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both"
o.ruler = true -- Show line and column number
o.colorcolumn = "80" -- Show ruler at 80 columns
o.textwidth = 80 -- Automatically break lines at 80 characters
o.wrap = true -- Enable visual line wrapping
o.linebreak = true -- Break at word boundaries, not mid-word

-- Indentation for JS/TS
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

-- Better search
o.ignorecase = true
o.smartcase = true

-- Better splits
o.splitbelow = true
o.splitright = true

-- Scroll offset
o.scrolloff = 8
o.sidescrolloff = 8

-- Better completion
o.updatetime = 250
o.timeoutlen = 300

-- Enable system clipboard
o.clipboard = "unnamedplus"

-- Disable swap files
o.swapfile = false
o.backup = false
o.undofile = true

-- Better colors
o.termguicolors = true

-- File encoding
o.fileencoding = "utf-8"

-- Line wrapping
o.wrap = true -- Enable visual line wrapping
o.linebreak = true -- Break at word boundaries, not mid-word

-- Sign column always on
o.signcolumn = "yes"

-- Enable mouse
o.mouse = "a"

-- Configure providers (disable unused)
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
