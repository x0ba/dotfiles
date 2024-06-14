{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;

      settings = {
        command = "${pkgs.fish}/bin/fish";
        mouse-hide-while-typing = true;

        quit-after-last-window-closed = true;
        window-theme = "auto";

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

        font-feature = [
          "calt"
          # "ss01"
        ];
      };

      keybindings = {
        "super+left" = "goto_split:left";
        "super+right" = "goto_split:right";
        "super+up" = "goto_split:top";
        "super+down" = "goto_split:bottom";

        "super+control+left" = "resize_split:left,40";
        "super+control+right" = "resize_split:right,40";
        "super+control+up" = "resize_split:up,40";
        "super+control+down" = "resize_split:down,40";

        "page_up" = "scroll_page_fractional:-0.5";
        "page_down" = "scroll_page_fractional:0.5";
      };
    };
  };
}
