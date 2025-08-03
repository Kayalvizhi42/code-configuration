-- plugins/dynamic-cursor.lua
return {
  {
    "custom/dynamic-cursor",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 9999,
    config = function()
      -- Neon colors for each mode (insert is now red)
      local neon = {
        n = "#39ff14", -- green (normal)
        i = "#ff3131", -- RED (insert, neon red)
        v = "#ff00ff", -- magenta (visual)
        V = "#ff00ff", -- magenta (visual-line)
        [""] = "#ff00ff", -- magenta (visual-block)
        c = "#ffff00", -- yellow (command)
        R = "#00ffff", -- cyan (replace) or pick another if you want
      }

      -- Blend two hex colors
      local function blend(bg, over, alpha)
        local function hex2rgb(hex)
          hex = hex:gsub("#", "")
          return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
        end
        local function rgb2hex(r, g, b)
          return string.format("#%02x%02x%02x", r, g, b)
        end
        local br, bgc, bb = hex2rgb(bg)
        local or_, og, ob = hex2rgb(over)
        local r = math.floor((1 - alpha) * br + alpha * or_ + 0.5)
        local g = math.floor((1 - alpha) * bgc + alpha * og + 0.5)
        local b = math.floor((1 - alpha) * bb + alpha * ob + 0.5)
        return rgb2hex(r, g, b)
      end

      -- Get the theme's default CursorLine bg
      local function get_default_cursorline_bg()
        local cl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
        if cl.bg then
          return string.format("#%06x", cl.bg)
        end
        return "#232323"
      end

      -- Set Cursor and CursorLine for a mode
      local function set_mode_highlights(mode)
        local color = neon[mode] or neon.n
        -- Cursor highlight
        vim.api.nvim_set_hl(0, "Cursor", { bg = color, fg = "#000000" })
        -- CursorLine: blend more (lighter, more transparent, e.g., 0.33)
        local default_bg = get_default_cursorline_bg()
        local blend_bg = blend(default_bg, color, 0.01)
        vim.api.nvim_set_hl(0, "CursorLine", { bg = blend_bg })
      end

      -- Update both on mode change
      local function update_all()
        local mode = vim.api.nvim_get_mode().mode
        set_mode_highlights(mode)
      end

      vim.api.nvim_create_autocmd("ColorScheme", { callback = update_all })
      vim.api.nvim_create_autocmd("ModeChanged", { callback = update_all })
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(update_all, 20)
        end,
      })

      vim.opt.guicursor = table.concat({
        "n-v-c:block-Cursor",
        "i-ci:ver50-Cursor",
        "r-cr:hor20-Cursor",
        "o:hor50-Cursor",
        "v-ve:ver35-Cursor",
      }, ",")

      vim.opt.cursorline = true
    end,
  },
}
