-- Go buffer-local settings. gofmt uses real tabs, so keep noexpandtab and
-- just choose how wide a tab is displayed.
local o = vim.opt_local

o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4

-- Treesitter-driven folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99 -- start with everything unfolded

-- ---------------------------------------------------------------------------
-- Keymaps (buffer-local, <leader>g prefix; LSP ones live in configs/lspconfig.lua).
-- <leader>gt and <leader>ds are taken by NvChad (git status / diagnostics), so
-- test and step-into maps avoid those prefixes.
-- ---------------------------------------------------------------------------
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
end

-- Jump between foo.go and foo_test.go
map("n", "<leader>ga", function()
  local file = vim.api.nvim_buf_get_name(0)
  local target = file:match "_test%.go$" and file:gsub("_test%.go$", ".go") or file:gsub("%.go$", "_test.go")
  vim.cmd.edit(vim.fn.fnameescape(target))
end, "Go alternate (source <-> test)")

-- Run tests in a split terminal
local function term(cmd)
  vim.cmd.split()
  vim.cmd.terminal(cmd)
  vim.cmd.startinsert()
end

-- The commands below run through 'shell', so arguments need shell quoting,
-- not Vim command-line escaping. shellescape() picks the right quoting for
-- the active shell: single quotes on macOS/Linux and PowerShell, double
-- quotes on Windows cmd.exe (where single quotes are literal and "^" is the
-- escape character).
local function pkg_dir()
  return vim.fn.shellescape(vim.fn.expand "%:p:h")
end

map("n", "<leader>gp", function()
  term "go test ./..."
end, "Go test package tree")

map("n", "<leader>gf", function()
  term("go test " .. pkg_dir())
end, "Go test current package")

map("n", "<leader>gn", function()
  -- Nearest enclosing test function via treesitter.
  local node = vim.treesitter.get_node()
  while node and node:type() ~= "function_declaration" do
    node = node:parent()
  end
  local name = node and vim.treesitter.get_node_text(node:field("name")[1], 0)
  if not name or not name:match "^Test" then
    vim.notify("Cursor is not inside a Test function", vim.log.levels.WARN)
    return
  end
  term(("go test %s -run %s -v"):format(pkg_dir(), vim.fn.shellescape("^" .. name .. "$")))
end, "Go test nearest")

map("n", "<leader>gr", function()
  term("go run " .. pkg_dir())
end, "Go run current package")

-- gopher.nvim
map("n", "<leader>gj", "<cmd>GoTagAdd json<CR>", "Go add json tags")
map("n", "<leader>gy", "<cmd>GoTagAdd yaml<CR>", "Go add yaml tags")
map("n", "<leader>gx", "<cmd>GoTagRm<CR>", "Go remove tags")
map("n", "<leader>ge", "<cmd>GoIfErr<CR>", "Go insert if err != nil")
map("n", "<leader>gG", "<cmd>GoTestAdd<CR>", "Go generate test for function")
map("n", "<leader>gA", "<cmd>GoTestsAll<CR>", "Go generate tests for file")
map("n", "<leader>gi", "<cmd>GoImpl<CR>", "Go implement interface (:GoImpl recv iface)")

-- Debugging (delve via nvim-dap-go)
map("n", "<leader>gd", function()
  require("dap-go").debug_test()
end, "Go debug nearest test")
map("n", "<leader>gD", function()
  require("dap-go").debug_last_test()
end, "Go debug last test")
-- The generic debugger keys (<leader>db, <leader>dc, <leader>dn, ...) are
-- global, see the nvim-dap entry in plugins/init.lua.
