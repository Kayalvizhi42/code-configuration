return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers", -- you can use "tabs" if you prefer tabpages instead
      style_preset = {
        require("bufferline").style_preset.no_italic,
        require("bufferline").style_preset.no_bold,
      },
      separator_style = "thick", -- options: "slant", "thick", "thin", etc
      indicator = {
        style = "underline",
      },
      numbers = function(opts)
        return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      show_buffer_close_icons = true,
      show_close_icon = true,
      modified_icon = "●",
      close_icon = "",
      buffer_close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      color_icons = true,
      show_tab_indicators = true,
      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },
    },
  },
}
