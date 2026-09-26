require("nvchad.configs.lspconfig").defaults()

-- NvChad sets mason's PATH option to "skip", so binaries installed with
-- :MasonInstall are not on $PATH. Prepend them here so lspconfig's default
-- `cmd`s (ngserver, vtsls, vscode-*-language-server, ...) resolve.
local mason_bin = vim.fn.stdpath "data" .. "/mason/bin"
if not vim.env.PATH:find(mason_bin, 1, true) then
  -- Windows separates PATH entries with ";" instead of ":".
  local sep = vim.fn.has "win32" == 1 and ";" or ":"
  vim.env.PATH = mason_bin .. sep .. vim.env.PATH
end

-- ---------------------------------------------------------------------------
-- Web: HTML / CSS / JSON
-- Install with :MasonInstall html-lsp css-lsp json-lsp
-- ---------------------------------------------------------------------------
vim.lsp.config("html", {
  -- Attach in Angular templates too (Neovim detects *.component.html as htmlangular).
  filetypes = { "html", "htmlangular", "templ" },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.enable { "html", "cssls", "jsonls" }

-- ---------------------------------------------------------------------------
-- TypeScript / JavaScript
--
-- vtsls wraps the same TypeScript extension VS Code uses and, with
-- `autoUseWorkspaceTsdk`, runs the `typescript` version pinned in the project,
-- so it always matches what `ng build` / `tsc` see.
-- Install with :MasonInstall vtsls
--
-- TypeScript 7 ships a native (Go) language server via `tsc --lsp`. It is much
-- faster but still lacks some refactors, and Angular's language service needs
-- the JS tsserver, so vtsls stays the default. Flip this to true to prefer the
-- native server in projects that have typescript >= 7 in node_modules
-- (lspconfig's `tsc` config only attaches when such a binary exists).
-- ---------------------------------------------------------------------------
local use_native_ts = false

local ts_inlay_hints = {
  enumMemberValues = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = { enabled = false },
}

vim.lsp.config("vtsls", {
  -- NvChad's global on_init disables semantic tokens; keep them for TS so
  -- types, enums, decorators, readonly members etc. get distinct colours.
  on_init = function() end,
  settings = {
    complete_function_calls = true,
    vtsls = {
      autoUseWorkspaceTsdk = true,
      enableMoveToFileCodeAction = true,
      experimental = {
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = ts_inlay_hints,
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = ts_inlay_hints,
    },
  },
})

vim.lsp.config("tsc", { on_init = function() end })

if use_native_ts then
  vim.lsp.enable "tsc"
else
  vim.lsp.enable "vtsls"
end

-- ---------------------------------------------------------------------------
-- Angular
--
-- angularls (the Angular Language Service) attaches in projects with an
-- angular.json / nx.json. It adds template intelligence (completions, go to
-- definition, diagnostics for bindings, signals, control flow) in
-- *.component.html and inline templates, on top of vtsls for the TS side.
-- lspconfig's default `cmd` probes the project's node_modules first, then
-- falls back to the @angular/language-service bundled with the mason package,
-- so it tracks the project's Angular version.
-- Install with :MasonInstall angular-language-server
-- ---------------------------------------------------------------------------
vim.lsp.config("angularls", { on_init = function() end })
vim.lsp.enable "angularls"

-- ---------------------------------------------------------------------------
-- ESLint (attaches only when the project has an eslint config)
-- Install with :MasonInstall eslint-lsp
-- ---------------------------------------------------------------------------
vim.lsp.enable "eslint"

-- ---------------------------------------------------------------------------
-- Java: nvim-java must be set up before jdtls is enabled.
-- It installs jdtls, java-debug-adapter, java-test and a JDK via mason on first run.
-- ---------------------------------------------------------------------------
require("java").setup()

vim.lsp.config("jdtls", {
  -- NvChad's global on_init disables semantic tokens; keep them for Java so
  -- fields, parameters, statics, deprecated symbols etc. get distinct colours.
  on_init = function() end,
})

vim.lsp.enable "jdtls"

-- ---------------------------------------------------------------------------
-- Go
--
-- gopls handles completion, navigation, diagnostics, inlay hints, code lenses
-- and semantic highlighting. gofumpt/goimports formatting on save lives in
-- configs/conform.lua; gopls is the fallback formatter.
-- Install with :MasonInstall gopls gofumpt goimports delve golangci-lint
--   golangci-lint-langserver gomodifytags impl gotests iferr
-- ---------------------------------------------------------------------------
vim.lsp.config("gopls", {
  -- NvChad's global on_init disables semantic tokens; keep them for Go so
  -- types, functions, variables, parameters, namespaces etc. get distinct
  -- colours (gopls >= 0.22 only sends them when the client asks, which
  -- lspconfig's default `semanticTokens = true` does).
  on_init = function() end,
  settings = {
    gopls = {
      gofumpt = true, -- stricter gofmt (matches the conform formatter)
      staticcheck = true,
      usePlaceholders = true, -- fill in argument/field placeholders on completion
      completeUnimported = true,
      directoryFilters = { "-.git", "-node_modules", "-.idea", "-.vscode" },
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        unusedvariable = true,
        nilness = true,
        shadow = true,
        useany = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      semanticTokens = true,
    },
  },
})
vim.lsp.enable "gopls"

-- golangci-lint via its language server. Only enabled when the binaries are
-- installed so a missing linter never spams "command not found" on attach.
-- Attaches in projects with a .golangci.yml (see lspconfig's root_markers).
if vim.fn.executable(mason_bin .. "/golangci-lint-langserver") == 1 then
  vim.lsp.enable "golangci_lint_ls"
end

-- ---------------------------------------------------------------------------
-- Buffer-local keymaps per server
-- ---------------------------------------------------------------------------
local function source_action(kind)
  return function()
    vim.lsp.buf.code_action { context = { only = { kind } }, apply = true }
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end

    if client.name == "jdtls" then
      map("<leader>jo", source_action "source.organizeImports", "Java organize imports")
    end

    if client.name == "vtsls" or client.name == "tsc" then
      map("<leader>to", source_action "source.organizeImports", "TS organize imports")
      map("<leader>ta", source_action "source.addMissingImports.ts", "TS add missing imports")
      map("<leader>tu", source_action "source.removeUnusedImports.ts", "TS remove unused imports")
      map("<leader>tf", source_action "source.fixAll.ts", "TS fix all")
    end

    if client.name == "vtsls" then
      -- Jump to the implementation instead of the .d.ts declaration.
      map("<leader>ts", function()
        local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
        client:exec_cmd({
          title = "Go to source definition",
          command = "typescript.goToSourceDefinition",
          arguments = { params.textDocument.uri, params.position },
        }, { bufnr = args.buf }, function(err, result)
          if err then
            vim.notify("Go to source definition failed: " .. err.message, vim.log.levels.ERROR)
          elseif not result or vim.tbl_isempty(result) then
            vim.notify("No source definition found", vim.log.levels.INFO)
          else
            vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
          end
        end)
      end, "TS go to source definition")
    end

    if client.name == "eslint" then
      map("<leader>te", "<cmd>LspEslintFixAll<CR>", "ESLint fix all")
    end

    if client.name == "gopls" then
      map("<leader>go", source_action "source.organizeImports", "Go organize imports")
      map("<leader>gl", vim.lsp.codelens.run, "Go run code lens (test/generate/tidy/...)")
      -- gopls-provided commands: `go mod tidy`, vulnerability check.
      map("<leader>gm", function()
        client:exec_cmd({
          title = "go mod tidy",
          command = "gopls.tidy",
          arguments = { { URIs = { vim.uri_from_bufnr(args.buf) } } },
        }, { bufnr = args.buf })
      end, "Go mod tidy")
      map("<leader>gv", function()
        client:exec_cmd({
          title = "govulncheck",
          command = "gopls.run_govulncheck",
          arguments = { { URI = vim.uri_from_bufnr(args.buf) } },
        }, { bufnr = args.buf })
      end, "Go run govulncheck")

      -- Show code lenses (run test / generate / tidy / ...) above declarations;
      -- Neovim keeps them refreshed as the buffer changes.
      if client:supports_method "textDocument/codeLens" then
        vim.lsp.codelens.enable(true, { bufnr = args.buf })
      end
    end

    if client:supports_method "textDocument/inlayHint" then
      map("<leader>ih", function()
        local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
      end, "LSP toggle inlay hints")
    end
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers
