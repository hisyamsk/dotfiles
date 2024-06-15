local wezterm = require("wezterm")
local config = {}

config.keys = {
	-- This will create a new split and run your default program inside it
	{
		key = '"',
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

config.color_scheme = "mykanagawa"
-- config.color_scheme = 'Twilight (base16)'
config.font = wezterm.font("JetBrains Mono", { weight = "Book" })
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.window_background_opacity = 0.92
config.window_padding = {
	left = 1,
	right = 1,
	top = 1,
	bottom = 0,
}
config.animation_fps = 1
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.force_reverse_video_cursor = true
config.front_end = "WebGpu"

config.window_frame = {
	font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),

	font_size = 10.0,

	active_titlebar_bg = "#1F1F28",

	inactive_titlebar_bg = "#363646",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#363646",
	},
}

config.force_reverse_video_cursor = true
config.color_schemes = {
	["mykanagawa"] = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#c34043", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
}

return config
