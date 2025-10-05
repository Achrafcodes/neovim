require "nvchad.mappings"

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- Save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up and down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Clear search highlighting
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Format
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- Package.json commands (when in package.json)
map("n", "<leader>ns", "<cmd>lua require('package-info').show()<CR>", { desc = "Show package info" })
map("n", "<leader>nc", "<cmd>lua require('package-info').hide()<CR>", { desc = "Hide package info" })
map("n", "<leader>nt", "<cmd>lua require('package-info').toggle()<CR>", { desc = "Toggle package info" })
map("n", "<leader>nu", "<cmd>lua require('package-info').update()<CR>", { desc = "Update package" })
map("n", "<leader>nd", "<cmd>lua require('package-info').delete()<CR>", { desc = "Delete package" })
map("n", "<leader>ni", "<cmd>lua require('package-info').install()<CR>", { desc = "Install package" })

-- Telescope (Next.js specific searches)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Terminal for running Next.js dev server
map("n", "<leader>tt", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "Toggle horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.5 }
end, { desc = "Toggle vertical terminal" })

-- Easy escape from terminal mode
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode with jj" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode with jk" })

-- Close terminal buffer from normal mode
map("n", "<leader>tc", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype == "terminal" then
    vim.cmd("bd!")
  else
    print("Not in a terminal buffer")
  end
end, { desc = "Close terminal buffer" })

-- Quick commands for MERN development
map("n", "<leader>nd", function()
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "npm run dev",
    id = "nextdev",
    clear_cmd = true,
  }
end, { desc = "Run Next.js dev server" })

map("n", "<leader>nb", function()
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "npm run build",
    id = "nextbuild",
    clear_cmd = true,
  }
end, { desc = "Build Next.js app" })

-- Run JavaScript file with Node.js
map("n", "<leader>rn", function()
  local file = vim.fn.expand("%:p")
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "node " .. file,
    id = "noderun",
    clear_cmd = false,
  }
end, { desc = "Run JS file with Node" })

-- F4: Toggle run JS file with Node.js (open/close terminal)
map("n", "<F4>", function()
  -- Check if terminal buffer exists and is valid
  if _G.node_term_buf and vim.api.nvim_buf_is_valid(_G.node_term_buf) then
    -- If terminal window is visible, close it
    if _G.node_term_win and vim.api.nvim_win_is_valid(_G.node_term_win) then
      vim.api.nvim_win_close(_G.node_term_win, true)
      _G.node_term_win = nil
      print("Terminal closed")
    else
      -- Terminal exists but not visible, show it
      vim.cmd("split")
      _G.node_term_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(_G.node_term_win, _G.node_term_buf)
      vim.cmd("wincmd p") -- Go back to previous window
      print("Terminal opened")
    end
  else
    -- No terminal exists, create new one and run node
    local file = vim.fn.expand("%:p")
    local ext = vim.fn.expand("%:e")
    
    if ext ~= "js" then
      print("Not a JavaScript file!")
      return
    end
    
    vim.cmd("split term://bash")
    _G.node_term_win = vim.api.nvim_get_current_win()
    _G.node_term_buf = vim.api.nvim_get_current_buf()
    
    local command = string.format("node %q\n", file)
    vim.fn.chansend(vim.b.terminal_job_id, command)
    vim.cmd("wincmd p") -- Go back to previous window
    print("Running: node " .. vim.fn.expand("%:t"))
  end
end, { desc = "Toggle: Run JS with Node" })

-- F4 also works in terminal mode to close it
map("t", "<F4>", function()
  if _G.node_term_win and vim.api.nvim_win_is_valid(_G.node_term_win) then
    vim.api.nvim_win_close(_G.node_term_win, true)
    _G.node_term_win = nil
  end
end, { desc = "Close Node terminal" })

-- Open HTML file in Chrome (for HTML files with <script> tags)
map("n", "<leader>rc", function()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  
  if ext == "html" then
    -- Open HTML file directly in Chrome
    vim.fn.system("google-chrome " .. vim.fn.shellescape(file) .. " &")
    print("Opened in Chrome: " .. file)
  elseif ext == "js" then
    -- For standalone JS: create temp HTML that loads the script
    local js_file = vim.fn.expand("%:t")
    local dir = vim.fn.expand("%:p:h")
    local html_file = dir .. "/_temp_run.html"
    
    local html_content = [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JS Runner</title>
</head>
<body>
  <h1>Check Console (F12)</h1>
  <script src="]] .. js_file .. [["></script>
</body>
</html>
]]
    
    -- Write temp HTML file
    local f = io.open(html_file, "w")
    if f then
      f:write(html_content)
      f:close()
      vim.fn.system("google-chrome " .. vim.fn.shellescape(html_file) .. " &")
      print("Opened JS in Chrome. Press F12 to see console output.")
    end
  else
    print("This command works only for .js or .html files")
  end
end, { desc = "Run in Chrome" })

-- Live Server alternative (using Python's http.server)
map("n", "<leader>rl", function()
  local file = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  local dir = vim.fn.expand("%:p:h")
  
  if ext == "html" then
    -- For HTML files, start server and open directly
    require("nvchad.term").runner {
      pos = "sp",
      cmd = "cd " .. dir .. " && python3 -m http.server 8000",
      id = "liveserver",
      clear_cmd = true,
    }
    vim.defer_fn(function()
      vim.fn.system("google-chrome http://localhost:8000/" .. file .. " &")
    end, 1500)
    print("Live server: http://localhost:8000/" .. file .. " (Press <leader>rs to stop)")
  elseif ext == "js" then
    -- For JS files, use the temp HTML approach
    local js_file = file
    local html_file = dir .. "/_temp_run.html"
    
    local html_content = [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JS Runner - ]] .. js_file .. [[</title>
  <style>
    body { font-family: monospace; padding: 20px; background: #1e1e1e; color: #d4d4d4; }
    h1 { color: #4ec9b0; }
    .info { background: #252526; padding: 10px; border-radius: 5px; margin: 20px 0; }
  </style>
</head>
<body>
  <h1>🚀 Running: ]] .. js_file .. [[</h1>
  <div class="info">
    <p>✅ Script loaded successfully</p>
    <p>📝 Open DevTools (F12) to see console output</p>
    <p>🔄 Edit your code and refresh (F5) to see changes</p>
  </div>
  <script src="]] .. js_file .. [["></script>
</body>
</html>
]]
    
    -- Write temp HTML file
    local f = io.open(html_file, "w")
    if f then
      f:write(html_content)
      f:close()
      
      -- Start server
      require("nvchad.term").runner {
        pos = "sp",
        cmd = "cd " .. dir .. " && python3 -m http.server 8000",
        id = "liveserver",
        clear_cmd = true,
      }
      
      -- Open in Chrome after short delay
      vim.defer_fn(function()
        vim.fn.system("google-chrome http://localhost:8000/_temp_run.html &")
      end, 1500)
      print("Live server: http://localhost:8000/_temp_run.html (Press <leader>rs to stop)")
    end
  else
    print("Live server works only for .js or .html files")
  end
end, { desc = "Start live server & open in Chrome" })

-- Stop live server
map("n", "<leader>rs", function()
  -- Kill the server process
  vim.fn.system("pkill -f 'python3 -m http.server 8000'")
  
  -- Close the terminal if it exists
  local terms = vim.api.nvim_list_bufs()
  for _, buf in ipairs(terms) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      local chan = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
      vim.fn.jobstop(chan)
    end
  end
  
  print("Live server stopped")
end, { desc = "Stop live server" })
