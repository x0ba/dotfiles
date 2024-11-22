local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "TITLE | RESIZE"
config.enable_wayland = false

config.font = wezterm.font("Cascadia Code")

config.font_size = 12
config.default_prog = { "/usr/bin/zsh" }
config.front_end = "WebGpu"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

return config
