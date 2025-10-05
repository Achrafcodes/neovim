-- ~/.config/nvim/lua/custom/plugins.lua
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = false,
      },
    },
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = false,    -- load immediately
    priority = 1000, -- load first
    config = function()
      local vscode = require("vscode")
      vscode.setup({
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
      })
      vscode.load("dark") -- or "light"
    end,
  },
}

