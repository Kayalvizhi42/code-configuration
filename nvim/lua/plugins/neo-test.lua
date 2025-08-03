return {
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
      "mrcjkb/rustaceanvim",
    },
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
        "neotest-plenary",
        ["neotest-golang"] = {
          dap_go_enabled = true,
          testify_enabled = true,
          warn_test_not_executed = true,
        },
        ["neotest-python"] = {},
        ["neotest-vitest"] = {},
      },
    },
  },
}
