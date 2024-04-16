{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    programs.ghostty = {
      enable = true;

      settings = {
        unfocused-split-opacity = 0.80;
        mouse-hide-while-typing = true;

        quit-after-last-window-closed = true;

        macos-option-as-alt = true;
        window-theme = "dark";

        font-family = "Liga Berkeley Mono";
        font-family-italic = "Operator Mono";
        font-size = 14;
        macos-titlebar-tabs = true;

        window-padding-x = 15;
        window-padding-y = 15;

        font-feature = ["-liga" "-dlig" "-calt"];
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
