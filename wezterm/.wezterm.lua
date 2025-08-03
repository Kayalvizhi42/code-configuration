-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- config.font = wezterm.font("MesloLGS Nerd Font Mono")

config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Noto Color Emoji" })

config.font_size = 16

config.enable_tab_bar = false

-- add this flag on macOS to force the drop shadow even with transparency

-- config.default_gui_startup_args = { "start", "--maximize" }
config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10
-- Always raise window when focusing
-- config.window_focus_change = true
-- config.color_scheme = "Mashup Colors (terminal.sexy)"

-- Melange_dark colorscheme
config.colors = {
	foreground = "#ece1d7",
	background = "#292522",
	cursor_bg = "#ece1d7",
	cursor_border = "#ece1d7",
	cursor_fg = "#292522",
	selection_bg = "#ece1d7",
	selection_fg = "#403a36",
	ansi = { "#34302c", "#bd8183", "#78997a", "#e49b5d", "#7f91b2", "#b380b0", "#7b9695", "#c1a78e" },
	brights = { "#867462", "#d47766", "#85b695", "#ebc06d", "#a3a9ce", "#cf9bc2", "#89b3b6", "#ece1d7" },
}

-- When a window gains focus, float it on top.
-- When it loses focus, restore normal stacking.
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}
-- Set default window size (columns x rows)
config.initial_cols = 90 -- Width in characters
config.initial_rows = 30 -- Height in characters

return config
