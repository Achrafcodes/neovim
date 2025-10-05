require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- MERN Stack LSP Servers
local servers = {
  "html",
  "cssls",
  "ts_ls", -- TypeScript/JavaScript
  "tailwindcss",
  "emmet_ls",
  "jsonls",
  "prismals", -- If using Prisma
  "eslint", -- ESLint integration
}

-- Default config for most servers
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end

-- Enhanced TypeScript/JavaScript setup with custom settings
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- Emmet for React
vim.lsp.config("emmet_ls", {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  settings = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})

-- Tailwind CSS with custom settings
vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

-- ESLint with auto-fix on save
vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json",
  },
})

-- Auto-fix ESLint on save using code actions
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  callback = function(args)
    -- Only run if ESLint LSP is attached
    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    local has_eslint = false
    for _, client in ipairs(clients) do
      if client.name == "eslint" then
        has_eslint = true
        break
      end
    end

    if has_eslint then
      -- Try the command first
      if vim.fn.exists(":EslintFixAll") > 0 then
        vim.cmd("EslintFixAll")
      else
        -- Fallback to code action
        vim.lsp.buf.code_action({
          context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
          apply = true,
        })
      end
    end
  end,
})
