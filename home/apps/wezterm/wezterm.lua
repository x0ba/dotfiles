-- luacheck: ignore scheme_for_appearance
local wezterm = require("wezterm")
local c = wezterm.config_builder()
function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Gruvbox Material (Gogh)"
  else
    return "GruvboxLight"
  end
end

require("config.keys").apply(c)

c.default_prog = { "/etc/profiles/per-user/daniel/bin/nu" }

c.font = wezterm.font_with_fallback({
  "Hack",
  "Symbols Nerd Font",
})

c.front_end = "WebGpu"
c.font_size = 13
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
}
c.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
c.use_fancy_tab_bar = false

c.window_padding = { left = 15, right = 15, top = 15, bottom = 0 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }
c.hide_tab_bar_if_only_one_tab = true

return c
