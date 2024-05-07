{ config, lib, ... }:
{
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;

      settings = {
        unfocused-split-opacity = 0.8;
        mouse-hide-while-typing = true;

        quit-after-last-window-closed = true;

        cursor-style = "block";
        cursor-style-blink = true;
        macos-option-as-alt = true;
        clipboard-read = "allow";
        clipboard-paste-protection = false;
        confirm-close-surface = false;

        font-family = "Liga Berkeley Mono";
        font-size = 13;

        window-padding-x = 10;
        window-padding-y = 10;

        macos-titlebar-tabs = true;

        font-feature = [
          "zero"
          "ss01"
          "ss02"
          "ss03"
          "ss04"
          "ss05"
          "ss06"
          "calt"
          "liga"
        ];
        theme = "catppuccin-mocha";

        font-codepoint-map = [
          "U+f000-U+f2e0,U+e200-U+e2a9=JetBrainsMono Nerd Font Mono"
          "U+e5fa-U+e6b1=JetBrainsMono Nerd Font Mono"
          "U+ea60-U+ebeb=JetBrainsMono Nerd Font Mono"
        ];
      };

      keybindings = {
        "super+left" = "goto_split:left";
        "super+right" = "goto_split:right";
        "super+up" = "goto_split:top";
        "super+down" = "goto_split:bottom";

        "page_up" = "scroll_page_fractional:-0.5";
        "page_down" = "scroll_page_fractional:0.5";
      };
    };
  };
}
