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
{
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}

