-- Rust buffer-local settings (rustfmt style: 4-space indent, 100 cols)
local o = vim.opt_local

o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.colorcolumn = "100"

-- Treesitter-driven folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99 -- start with everything unfolded

-- ---------------------------------------------------------------------------
-- Keymaps (buffer-local, <leader>r prefix). Most run rustaceanvim's :RustLsp
-- command, which asks rust-analyzer (see :h rustaceanvim.commands).
-- <leader>ra (rename) and <leader>rn (relative numbers) are NvChad's. The code
-- lens key (<leader>rl) lives in configs/lspconfig.lua and the generic
-- debugger keys (<leader>db, <leader>dc, ...) in plugins/init.lua.
-- ---------------------------------------------------------------------------
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
end

-- Callback that runs `:RustLsp <args>`; `bang = true` reruns the last target.
local function rust_lsp(args)
  return function()
    vim.cmd.RustLsp(args)
  end
end

-- Run, test and debug through rust-analyzer's runnables (cargo run / test /
-- doctests, with the right package and target). "at cursor" uses the target
-- enclosing the cursor; the pickers list every target in the workspace.
map("n", "<leader>rr", rust_lsp { "run" }, "Rust run target at cursor")
map("n", "<leader>rR", rust_lsp { "runnables" }, "Rust pick a runnable")
map("n", "<leader>rt", rust_lsp { "testables" }, "Rust pick a test target")
map("n", "<leader>rT", rust_lsp { "testables", bang = true }, "Rust rerun last test target")
map("n", "<leader>rd", rust_lsp { "debug" }, "Rust debug target at cursor")
map("n", "<leader>rD", rust_lsp { "debuggables" }, "Rust pick a debuggable")

-- Build in a split terminal
map("n", "<leader>rb", function()
  vim.cmd.split()
  vim.cmd.terminal "cargo build"
  vim.cmd.startinsert()
end, "Rust cargo build")

-- Diagnostics: the full rustc rendering (what `cargo build` prints, including
-- the borrow-checker notes) and the error-code explanation (`rustc --explain`).
map("n", "<leader>re", rust_lsp { "renderDiagnostic" }, "Rust show full rustc diagnostic")
map("n", "<leader>rE", rust_lsp { "explainError" }, "Rust explain error code")

-- Code actions with rust-analyzer's grouping (e.g. "Import ▶" submenus);
-- replaces Neovim's default gra in Rust buffers. In visual mode the `:`
-- inserts the '<,'> range so the action applies to the selection.
map("n", "gra", rust_lsp { "codeAction" }, "Rust code action")
map("x", "gra", ":RustLsp codeAction<CR>", "Rust code action")
map("n", "<leader>rh", rust_lsp { "hover", "actions" }, "Rust hover with actions")
map("n", "<leader>rm", rust_lsp { "expandMacro" }, "Rust expand macro recursively")
map("n", "<leader>rj", rust_lsp { "joinLines" }, "Rust join lines")
map("x", "<leader>rj", ":RustLsp joinLines<CR>", "Rust join lines")
-- Leaves the command line open for the `search ==>> replace` pattern.
map({ "n", "x" }, "<leader>rs", ":RustLsp ssr ", "Rust structural search replace")

-- Navigation
map("n", "<leader>rp", rust_lsp { "parentModule" }, "Rust go to parent module")
map("n", "<leader>rc", rust_lsp { "openCargo" }, "Rust open Cargo.toml")
map("n", "<leader>ro", rust_lsp { "openDocs" }, "Rust open docs.rs for symbol")
