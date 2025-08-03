-- lua/plugins/colorscheme.lua
return {
  {
    "savq/melange-nvim",
    lazy = false, -- load on startup
    priority = 1000, -- make sure it loads before other UI plugins
    config = function()
      vim.opt.termguicolors = true
      -- optional: choose light or dark
      -- vim.o.background = "light"  -- default is "dark"
      vim.cmd.colorscheme("melange")
    end,
  },
}
