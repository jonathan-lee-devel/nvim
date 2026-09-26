-- go.mod buffer-local settings (gofmt-style tabs)
local o = vim.opt_local

o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4

vim.keymap.set("n", "<leader>gm", "<cmd>GoMod tidy<CR>", { buffer = true, desc = "Go mod tidy" })
