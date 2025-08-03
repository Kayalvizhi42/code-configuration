-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor", -- Normal, Visual, Command: block cursor, highlight group Cursor/lCursor
  "i-ci:ver25-CursorInsert/lCursorInsert", -- Insert, Command-Insert: vertical bar cursor, highlight group CursorInsert/lCursorInsert
  "r-cr:hor20-CursorReplace/lCursorReplace", -- Replace, Command-Replace: horizontal underline cursor
  "o:hor50", -- Operator-pending: thick horizontal
  "a:blinkon0", -- Disable blinking
}
