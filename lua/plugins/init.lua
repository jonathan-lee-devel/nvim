return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- needed for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Java starter pack: jdtls, debugger, test runner, spring-boot support.
      -- Loaded before lspconfig so `require("java").setup()` can run first.
      {
        "nvim-java/nvim-java",
        dependencies = {
          "MunifTanjim/nui.nvim",
          "mfussenegger/nvim-dap",
          { "JavaHello/spring-boot.nvim", commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0" },
        },
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- File explorer: widen the sidebar (NvChad default is 30 columns).
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { width = 80 },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "luadoc", "printf", "vimdoc",
        "java",
        -- Angular / TypeScript web stack. `angular` parses .component.html
        -- templates (control flow, bindings); `tsx`, `jsdoc` and `regex` are
        -- injected into typescript/javascript for full highlighting.
        "typescript", "tsx", "javascript", "jsdoc", "regex",
        "angular", "html", "css", "scss",
        "json", "yaml", "markdown", "markdown_inline",
        -- Go. `gomod`/`gosum`/`gowork` highlight the module files, `gotmpl`
        -- covers text/template and html/template files.
        "go", "gomod", "gosum", "gowork", "gotmpl",
        -- Rust. `toml` covers Cargo.toml, Cargo.lock and rustfmt.toml.
        "rust", "toml",
      },
    },
  },

  -- Go helpers: struct tags (:GoTagAdd json), `if err != nil` snippet
  -- (:GoIfErr), test stubs (:GoTestAdd / :GoTestsAll), interface impls
  -- (:GoImpl), :GoMod tidy, :GoGenerate. See after/ftplugin/go.lua for keymaps.
  -- Binaries come from mason (see configs/lspconfig.lua for the install line).
  {
    "olexsmir/gopher.nvim",
    ft = { "go", "gomod" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = function()
      local mason_bin = vim.fn.stdpath "data" .. "/mason/bin/"
      return {
        commands = {
          gomodifytags = mason_bin .. "gomodifytags",
          gotests = mason_bin .. "gotests",
          impl = mason_bin .. "impl",
          iferr = mason_bin .. "iferr",
        },
      }
    end,
  },

  -- Debug Go with delve: launch configs for the current file/package and
  -- `require("dap-go").debug_test()` for the test under the cursor.
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = function()
      -- nvim-dap spawns the adapter with libuv directly, which on Windows
      -- only resolves .com/.exe. Mason's bin dir holds .cmd shims there, so
      -- the extension has to be explicit.
      local ext = vim.fn.has "win32" == 1 and ".cmd" or ""
      return {
        delve = { path = vim.fn.stdpath "data" .. "/mason/bin/dlv" .. ext },
      }
    end,
  },

  -- Generic debugger keys, shared by every language with a DAP adapter (delve
  -- for Go, codelldb for Rust). The language-specific launchers live in the
  -- ftplugins (<leader>gd / <leader>rd).
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP toggle breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<CR>", desc = "DAP continue / start" },
      { "<leader>dn", "<cmd>DapStepOver<CR>", desc = "DAP step over" },
      { "<leader>di", "<cmd>DapStepInto<CR>", desc = "DAP step into" },
      { "<leader>do", "<cmd>DapStepOut<CR>", desc = "DAP step out" },
      { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "DAP toggle REPL" },
      { "<leader>dq", "<cmd>DapTerminate<CR>", desc = "DAP terminate" },
    },
  },

  -- Rust: rustaceanvim starts and configures rust-analyzer itself (lspconfig's
  -- rust_analyzer must stay disabled) and adds the :RustLsp commands used in
  -- after/ftplugin/rust.lua: runnables, testables, debuggables (codelldb from
  -- mason), macro expansion, rendered diagnostics, grouped code actions, ...
  -- Settings live in configs/rustaceanvim.lua.
  -- Install with: rustup component add rust-analyzer rust-src
  --           and :MasonInstall codelldb
  {
    "mrcjkb/rustaceanvim",
    version = "^9", -- v9 needs Neovim >= 0.12
    ft = { "rust" },
    -- nvim-lspconfig first, so NvChad's vim.lsp.config("*") defaults and the
    -- rust-analyzer entry in configs/lspconfig.lua exist when the client starts.
    dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
    init = function()
      -- Must be set before the plugin loads; a function defers the require.
      vim.g.rustaceanvim = function()
        return require "configs.rustaceanvim"
      end
    end,
  },

  -- Cargo.toml: newest crate versions as virtual text, completion of crate
  -- names / versions / features, K hover and gra update/upgrade actions, all
  -- through an in-process language server. Keymaps in after/ftplugin/toml.lua.
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    },
  },

  -- JSON schemas for angular.json, tsconfig.json, package.json, etc. (used by jsonls)
  { "b0o/SchemaStore.nvim", lazy = true },

  -- Colour-cycled brackets/braces, driven by treesitter (see chadrc integrations)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
      require("rainbow-delimiters.setup").setup {}
    end,
  },
}
