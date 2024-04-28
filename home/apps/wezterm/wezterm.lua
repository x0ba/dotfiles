local wezterm = require("wezterm")
local c = wezterm.config_builder()
local utils = require("config.utils")

require("config.keys").apply(c)

c.font = wezterm.font("Liga SFMono Nerd Font")
c.front_end = "WebGpu"
c.font_size = 14
c.harfbuzz_features = { "calt=1", "ss01=1" }
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
}

c.window_decorations = "RESIZE"
c.window_padding = { left = 30, right = 30, top = 20, bottom = 10 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }
c.hide_tab_bar_if_only_one_tab = true
c.color_scheme = "Tokyo Night"

-- some annoying bug is causing crashes on sway
if utils.is_darwin() then
  require("bar.plugin").apply_to_config(c)
end

-- require("catppuccin.plugin").apply_to_config(c)

return c
