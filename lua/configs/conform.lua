local mason_bin = vim.fn.stdpath "data" .. "/mason/bin/"

-- Filetypes formatted by prettier (Angular/TypeScript web stack).
local prettier_fts = {
  "javascript", "javascriptreact", "typescript", "typescriptreact",
  "html", "htmlangular", "css", "scss", "less",
  "json", "jsonc", "yaml", "markdown", "graphql",
}

local formatters_by_ft = {
  lua = { "stylua" },
  java = { "google-java-format" },
  -- goimports fixes the import block, gofumpt applies the stricter gofmt.
  go = { "goimports", "gofumpt" },
  -- rustfmt from the rustup toolchain (on $PATH); rust-analyzer is the fallback.
  rust = { "rustfmt" },
}
for _, ft in ipairs(prettier_fts) do
  formatters_by_ft[ft] = { "prettier" }
end

local options = {
  formatters_by_ft = formatters_by_ft,

  formatters = {
    -- Install with :MasonInstall goimports gofumpt
    goimports = { command = mason_bin .. "goimports" },
    gofumpt = { command = mason_bin .. "gofumpt" },

    -- The edition comes from the nearest Cargo.toml; this default only applies
    -- to files outside a cargo project.
    rustfmt = { options = { default_edition = "2024" } },

    -- NvChad sets mason's PATH option to "skip", so point at the binary directly.
    -- Install with :MasonInstall google-java-format
    ["google-java-format"] = {
      command = mason_bin .. "google-java-format",
      -- args = { "--aosp", "-" }, -- uncomment for 4-space indentation (Android/AOSP style)
    },

    -- Prefer the project's own prettier (so its version and plugins are used),
    -- fall back to mason's. Install the fallback with :MasonInstall prettier
    prettier = {
      command = function(_, ctx)
        local root = vim.fs.root(ctx.dirname, "node_modules")
        local local_bin = root and (root .. "/node_modules/.bin/prettier")
        if local_bin and vim.fn.executable(local_bin) == 1 then
          return local_bin
        end
        return mason_bin .. "prettier"
      end,
      -- Only run when the project has a prettier config (.prettierrc, prettier.config.js,
      -- "prettier" key in package.json, ...). Keeps save from reformatting projects that
      -- don't use prettier.
      require_cwd = true,
    },
  },

  -- Format on save: Java always (google-java-format), Go always
  -- (goimports + gofumpt, gopls as fallback), Rust always (rustfmt,
  -- rust-analyzer as fallback); web filetypes only when the
  -- project has a prettier config (see require_cwd above), never via LSP so
  -- unconfigured projects are left untouched. <leader>fm still formats on
  -- demand with LSP fallback.
  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "java" or ft == "go" or ft == "rust" then
      return { timeout_ms = 2000, lsp_fallback = true }
    end
    if vim.tbl_contains(prettier_fts, ft) then
      return { timeout_ms = 3000, lsp_format = "never" }
    end
  end,
}

return options
