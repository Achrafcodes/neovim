---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",
}

M.plugins = {
  user = {
    ["rockyzhang24/arctic.nvim"] = {
      lazy = false,
      priority = 1000,
      dependencies = { "rktjmp/lush.nvim" },
      config = function()
        vim.cmd.colorscheme("arctic")
      end,
    },
  },
}

return M

