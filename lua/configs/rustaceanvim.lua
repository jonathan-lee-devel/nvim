-- rustaceanvim: rust-analyzer settings, tools and debugging. Read lazily
-- through vim.g.rustaceanvim (see plugins/init.lua), so it must not be required
-- from after/ftplugin/rust.lua. The vim.lsp.config("rust-analyzer") entry in
-- configs/lspconfig.lua is merged on top of `server` below.
-- Docs: :h rustaceanvim.config and https://rust-analyzer.github.io/book/configuration

local M = {
  tools = {
    code_actions = {
      -- gra runs :RustLsp codeAction (after/ftplugin/rust.lua) to get
      -- rust-analyzer's grouped actions; use the plain picker when there are none.
      ui_select_fallback = true,
    },
  },

  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          buildScripts = { enable = true }, -- run build.rs so generated code resolves
          -- features = "all", -- uncomment to analyse code behind every cargo feature
        },
        -- Lint with clippy instead of `cargo check` on save. rustaceanvim already
        -- does this when clippy is installed; explicit so it is easy to turn off.
        check = { command = "clippy" },
        checkOnSave = true,
        procMacro = { enable = true },
        -- "Run | Debug" lenses above main() and tests, "N implementations"
        -- above traits. Run the one under the cursor with <leader>rl
        -- (configs/lspconfig.lua).
        lens = {
          enable = true,
          run = { enable = true },
          debug = { enable = true },
          implementations = { enable = true },
        },
        -- Toggled with <leader>ih (off by default, like the other languages).
        inlayHints = {
          bindingModeHints = { enable = true }, -- `ref` / `ref mut` in patterns
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
        },
      },
    },
  },
}

-- Debugging: codelldb from :MasonInstall codelldb. rustaceanvim can find it
-- through mason's registry on its own, but mason's bin entry is a wrapper
-- (a .cmd shim on Windows), so point nvim-dap at the adapter binary inside
-- the package directly, the same way delve is wired up in plugins/init.lua.
-- Without the package rustaceanvim falls back to lldb-dap from $PATH.
local ext = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
local codelldb, liblldb
if vim.fn.has "win32" == 1 then
  codelldb = ext .. "adapter/codelldb.exe"
  liblldb = ext .. "lldb/bin/liblldb.dll"
else
  codelldb = ext .. "adapter/codelldb"
  liblldb = ext .. "lldb/lib/liblldb" .. (vim.fn.has "mac" == 1 and ".dylib" or ".so")
end
if vim.fn.executable(codelldb) == 1 then
  M.dap = { adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, liblldb) }
end

return M
