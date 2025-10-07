vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- DISABLE SIGNATURE HELP POPUP
vim.lsp.handlers["textDocument/signatureHelp"] = function() end

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme FIRST (before anything else)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- FORCE ONEDARK THEME AFTER EVERYTHING LOADS
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Wait a bit for all plugins to load
    vim.defer_fn(function()
      -- Force reload the theme
      dofile(vim.g.base46_cache .. "defaults")
      dofile(vim.g.base46_cache .. "statusline")
      
      -- Override terminal background
      vim.cmd([[
        highlight Normal guibg=#282c34 guifg=#abb2bf
        highlight NormalNC guibg=#282c34 guifg=#abb2bf
        highlight NvimTreeNormal guibg=#282c34
        highlight SignColumn guibg=#282c34
        highlight LineNr guibg=#282c34
      ]])
    end, 100)
  end,
})

-- Compile & Run C (toggle terminal)
vim.keymap.set("n", "<leader>s", function()
  -- Check if the current buffer is a normal file (not a terminal)
  if vim.bo.buftype == "" then
    -- Save the current file if it's a normal buffer
    vim.cmd("write")
    print("File saved.")
  end

  -- Get the filename with extension (e.g., my_program.c)
  local file = vim.fn.expand("%:t")
  -- Get the directory of the current file
  local current_dir = vim.fn.expand("%:p:h")

  if _G.cc_term_buf and vim.api.nvim_buf_is_valid(_G.cc_term_buf) then
    if _G.cc_term_win and vim.api.nvim_win_is_valid(_G.cc_term_win) then
      vim.api.nvim_win_close(_G.cc_term_win, true)
    end
    vim.api.nvim_buf_delete(_G.cc_term_buf, { force = true })
    _G.cc_term_buf, _G.cc_term_win = nil, nil
    print("Closed compile terminal")
    return
  end

  -- open a terminal buffer and compile/run
  vim.cmd("split term://bash")
  _G.cc_term_win = vim.api.nvim_get_current_win()
  _G.cc_term_buf = vim.api.nvim_get_current_buf()

  -- The command to change directory, compile, clear the screen, run,
  -- and then wait for a key press
  local command = string.format(
    "cd %q && cc -Wall -Wextra -Werror %q > /dev/null && clear && ./a.out | cat -e && read -n 1 -p $'\nPress any key to close the terminal...'\n",
    current_dir,
    file
  )

  vim.fn.chansend(vim.b.terminal_job_id, command)
end, { desc = "Save, Compile & Run C" })


-- Escape insert mode quickly
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })

vim.keymap.set("n", "<leader>cf", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("%!clang-format") 
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap = true, silent = true, desc = "Format C file" })


-- REMOVE TRANSPARENCY - Force OneDark colors
vim.cmd([[
  highlight Normal guibg=#282c34 guifg=#abb2bf
  highlight NormalNC guibg=#282c34 guifg=#abb2bf
  highlight NvimTreeNormal guibg=#282c34
]])

vim.opt.clipboard = "unnamedplus"
vim.lsp.inlay_hint.enable(false)
