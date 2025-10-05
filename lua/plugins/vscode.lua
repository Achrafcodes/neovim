return {
     {
       "Mofiqul/vscode.nvim",
       lazy = false, -- Load immediately since it's a colorscheme
       priority = 1000, -- High priority for colorschemes
       config = function()
         require('vscode').setup({
           -- Optional configuration
           transparent = true,        -- Enable transparent background
           italic_comments = true,    -- Enable italic comments
           disable_nvimtree_bg = true, -- Disable nvim-tree background color
         })
       end,
     },
   }
