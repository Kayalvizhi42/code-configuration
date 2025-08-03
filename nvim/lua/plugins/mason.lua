return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "css-lsp",
        "tailwindcss-language-server",
        "js-debug-adapter",
        "codelldb",
        "pyright",
        "ruff",
        "prettier",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
}
