local wezterm = require("wezterm")
local c = wezterm.config_builder()
local utils = require("config.utils")

require("config.font-switcher").apply(c, {
  fonts = {
    { font = "BlexMono Nerd Font" },
    { font = "ComicCodeLigatures Nerd Font" },
    { font = "CaskaydiaCove Nerd Font" },
    { font = "IntoneMono Nerd Font" },
    { font = "JetBrainsMono Nerd Font" },
    { font = "MonaspiceAr Nerd Font" },
    { font = "MonaspiceKr Nerd Font" },
    { font = "MonaspiceNe Nerd Font" },
    { font = "MonaspiceRn Nerd Font" },
    { font = "MonaspiceXe Nerd Font" },
  },
})
require("config.keys").apply(c)
require("config.zen-mode")

c.front_end = "WebGpu"

if utils.is_darwin() then
  c.macos_window_background_blur = 20
  c.window_background_opacity = 0.95
  c.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
  c.window_padding = { left = 10, right = 10, top = 50, bottom = 5 }
  c.default_prog = { "/bin/zsh", "-l" }
else
  c.window_padding = { left = 10, right = 10, top = 5, bottom = 5 }
  c.default_prog = { "/usr/bin/zsh", "-l" }
end

c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }
c.color_scheme = "GruvboxDark"

c.tab_bar_at_bottom = true
c.tab_bar_at_bottom = true
c.use_fancy_tab_bar = false

return c
