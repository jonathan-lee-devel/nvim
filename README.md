**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

# Windows setup

The config is cross-platform: PATH handling, the delve and codelldb paths
and the Go test runner all detect Windows (`has("win32")`) and adjust. What follows
is the toolchain the plugins expect to find on the machine.

## 1. Install the tools

Using [winget](https://learn.microsoft.com/windows/package-manager/) from
an elevated PowerShell:

```powershell
winget install Neovim.Neovim Git.Git BurntSushi.ripgrep.MSVC
winget install OpenJS.NodeJS.LTS GoLang.Go Microsoft.OpenJDK.21 Rustlang.Rustup
winget install zig.zig tree-sitter.tree-sitter-cli
```

| Tool | Needed by |
| --- | --- |
| git | lazy.nvim bootstrap, mason |
| ripgrep | Telescope live grep |
| node / npm | vtsls, angular-language-server, eslint-lsp, html/css/json-lsp, prettier |
| go | gopls, delve and the other Go tools |
| JDK | google-java-format (nvim-java installs its own JDK for jdtls) |
| rustup (cargo, rustc, rustfmt, clippy) | rust-analyzer, rustaceanvim's cargo runnables, format on save. The MSVC toolchain needs the Visual Studio C++ Build Tools; rustup's installer offers to set them up |
| zig (or MSVC Build Tools / MinGW gcc) | nvim-treesitter compiles parsers locally |
| tree-sitter CLI 0.26.1+ | nvim-treesitter `main` branch |

`tar` and `curl` are also required by nvim-treesitter; both ship with
Windows 10 and later.

Install the **SauceCodePro Nerd Font** from
<https://www.nerdfonts.com/font-downloads> and select it in your terminal
(Windows Terminal is recommended). Open a new terminal afterwards so the
updated PATH is picked up.

## 2. Clone the config

Neovim on Windows reads its config from `%LOCALAPPDATA%\nvim` and stores
plugins and mason packages under `%LOCALAPPDATA%\nvim-data`.

```powershell
git clone https://github.com/jonathan-lee-devel/nvim.git $env:LOCALAPPDATA\nvim
nvim
```

The first start bootstraps lazy.nvim, installs the plugins and compiles the
treesitter parsers. Restart Neovim once that finishes.

## 3. Install the language servers and formatters

Inside Neovim:

```vim
:MasonInstall html-lsp css-lsp json-lsp vtsls angular-language-server eslint-lsp
:MasonInstall prettier stylua google-java-format
:MasonInstall gopls gofumpt goimports delve golangci-lint golangci-lint-langserver gomodifytags impl gotests iferr
:MasonInstall codelldb
```

nvim-java installs jdtls, the Java debug adapter, the test runner and a JDK
on its own the first time a Java file is opened.

rust-analyzer comes from rustup rather than Mason so it always matches the
toolchain that builds the project (`rust-src` lets it index the standard
library). In a terminal:

```powershell
rustup component add rust-analyzer rust-src
```

## Notes

- Mason writes `.cmd` shims into `nvim-data\mason\bin` on Windows instead
  of symlinks. The config accounts for this; if you add a plugin that
  spawns a mason binary by absolute path, append `.cmd` on Windows.
- The Go test/run keymaps (`<leader>gp`, `<leader>gf`, `<leader>gn`,
  `<leader>gr`) and the Rust ones (`<leader>rr`, `<leader>rt`,
  `<leader>rb`, ...) run through `'shell'`. They work with the default
  `cmd.exe`; if you prefer PowerShell, set `vim.o.shell = "pwsh"` in
  `lua/options.lua`.
- Rust debugging uses Mason's codelldb. `lua/configs/rustaceanvim.lua`
  points nvim-dap at `codelldb.exe` and `liblldb.dll` inside the Mason
  package on Windows, so nothing else is needed.
- Run `:checkhealth` after setup to confirm the compiler, tree-sitter CLI
  and ripgrep were found.
