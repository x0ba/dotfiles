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
        font-size = 12;

        window-padding-x = 10;
        window-padding-y = 10;

        macos-titlebar-tabs = true;

        # font-feature = [
        #   "calt"
        #   "ss02"
        # ];
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
