require "nvchad.options"

local o = vim.o
local g = vim.g

-- FORCE NEOVIM TO USE ITS OWN COLORS (not terminal theme)
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
vim.cmd([[
  set t_Co=256
  set t_ut=
]])

-- Disable terminal background override - FORCE NVIM COLORS
vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
  pattern = "*",
  callback = function()
    -- Force Neovim to use its own colors, NOT terminal colors
    vim.opt.termguicolors = true
    -- Remove any transparent background
    vim.cmd([[
      highlight Normal ctermbg=NONE guibg=#1e1e1e guifg=#d4d4d4
      highlight NormalNC ctermbg=NONE guibg=#1e1e1e guifg=#d4d4d4
      highlight SignColumn guibg=#1e1e1e
      highlight LineNr guibg=#1e1e1e
      highlight CursorLineNr guibg=#1e1e1e
    ]])
  end,
})

-- Better editing experience
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both"
o.ruler = true
o.colorcolumn = "80"
o.textwidth = 80
o.wrap = true
o.linebreak = true

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

-- Better colors - MUST BE TRUE
o.termguicolors = true

-- File encoding
o.fileencoding = "utf-8"

-- Sign column always on
o.signcolumn = "yes"

-- Enable mouse
o.mouse = "a"

-- Configure providers (disable unused)
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
