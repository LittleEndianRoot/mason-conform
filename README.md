# mason-conform.nvim

`mason-conform.nvim` is a Neovim plugin used as a bridging handler between `mason.nvim` and `conform.nvim`. 
It allows automatic checking and installation of formatters in the `mason.nvim` registry and `conform.nvim` configuration. 

## Requirements

-   neovim `>= 0.7.0`
-   ['mason.nvim'](https://github.com/williamboman/mason.nvim)
-   ['conform.nvim'](https://github.com/stevearc/conform.nvim)

# Install

### [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
    "LittleEndianRoot/mason-conform.nvim",
}
```

### [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
    "LittleEndianRoot/mason-conform.nvim"
}
```

## Load order

It's crucial to setup plugins in the following order:

1. `mason.nvim`
2. `conform.nvim`
3. `mason-conform.nvim`

Otherwise `mason-conform.nvim` will not have enough information about configured formatters and
access to the mason registry.

To learn about the available settings and configurations, please refer the [Configuration](#configuration) section.

## Configuration

You can configure the behaviour of `mason-conform` by passing the configuration to 'setup()'.
All available settings are provided in [default configuration](#default-configuration) section.

Example:

```lua
require("mason-conform").setup()
```

### Default configuration
```lua
local DEFAULT_SETTINGS = {
    -- a list of formatters to automatically install if they're not already installed. example: { "asmfmt", "ast-grep" }
    -- this setting has no relation with the `automatic_installation` setting.
    -- names of formatters should be taken from mason's registry.
    ---@type string[]
    ensure_installed = {},

    -- whether formatters are set up (via conform) should be automatically installed if they're not installed already.
    -- it tries to find the specified formatters in mason's registry to proceed with installation.
    -- this setting has no relation with `ensure_installed` setting.
    ---@type boolean
  automatic_installation = true,

    -- disables warning notifications about misconfiguration such as invalid formatter entries and incorrect plugin load order.
    quiet_mode = false,
}
```
#### Basic Customisation

Using this configuration, only formatters specified in `ensure_installed` will be installed. Ones specified in `conform.nvim` will be ignored.
NOTE: The formatters in `ensure_installed` should be written in the format of mason's registry (https://mason-registry.dev/).

```lua
require('mason-conform').setup({
    ensure_installed = { 'black', "prettier" },
})
```

#### Another Customisation

```lua
M.formatters = {
    'black',
    'prettier',
}

function M.config()
    local m_conform = require("mason-conform")

    m_conform.setup({
        ensure_installed = M.formatters,
    })
end
```

## Mason formatters registry
You can find a list of mason registry packages at [mason registry](https://github.com/mason-org/mason-registry)

Since LSP servers, linters, DAPs and Formatters are all grouped together in the packages directory in the link above.
Here is a list of just Formatters from the Mason registry:
```
  asmfmt
  ast-grep
  autoflake
  autopep8
  beautysh
  bibtex-tidy
  biome
  black
  blade-formatter
  blue
  buf
  buildifier
  cbfmt
  clang_format
  cmake_format
  codespell
  csharpier
  darker
  deno_fmt
  djlint
  dprint
  easy-coding-standard
  elm_format
  eslint_d
  fantomas
  fixjson
  fourmolu
  gci
  gdformat
  gersemi
  gofumpt
  goimports-reviser
  goimports
  golines
  google-java-format
  htmlbeautifier
  isort
  joker
  jq
  jsonnetfmt
  ktlint
  latexindent
  markdown-toc
  markdownlint-cli2
  markdownlint
  mdformat
  mdslw
  nixpkgs_fmt
  ocamlformat
  php_cs_fixer
  phpcbf
  pint
  prettier
  prettierd
  pretty-php
  reorder-python-imports
  rubocop
  rubyfmt
  ruff_fix
  ruff_format
  rufo
  rustfmt
  rustywind
  shellcheck
  shellharden
  shfmt
  sql_formatter
  sqlfluff
  sqlfmt
  standardjs
  standardrb
  stylelint
  stylua
  taplo
  templ
  tlint
  typos
  usort
  xmlformat
  yamlfix
  yamlfmt
  yapf
  yq
  zprint
```

## Copyright
I needed a working helper to installed mason formatters automatically without manual intervention (after initial configuration). So it is no surprise that `mason-conform.nvim` is a copy of another great plugin with the same functionality only for linters called [mason-nvim-lint](https://github.com/rshkarin/mason-nvim-lint) 
`mason-nvim-lint` is in itself inspired from [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
