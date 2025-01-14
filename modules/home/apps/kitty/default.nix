{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.kitty;
in {
  options.${namespace}.apps.kitty = {
    enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      settings = {
        font_family = "BerkeleyMono Nerd Font";
        font_size = 12;

        placement_strategy = "top-left";
        inactive_text_alpha = 0.8;
        window_padding_width = 5;

        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";

        tab_bar_align = "left";
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_bar_margin_width = 0.0;
        tab_powerline_style = "slanted";
        enabled_layouts = "splits, stack";

        # always show tab bar
        tab_bar_min_tabs = 1;

        tab_title_template = "{index}: {title}{sup.num_windows if num_windows > 1 else ''}{activity_symbol}{bell_symbol}";

        macos_option_as_alt = "yes";
      };

      keybindings = {
        # this emulates zooming panes
        "ctrl+s>z" = "toggle_layout stack";

        # create new panes
        "ctrl+s>-" = "launch --location=hsplit --cwd=current";
        "ctrl+s>\\" = "launch --location=vsplit --cwd=current";

        # jump to other panes
        "ctrl+s>h" = "neighboring_window left";
        "ctrl+s>l" = "neighboring_window right";
        "ctrl+s>k" = "neighboring_window up";
        "ctrl+s>j" = "neighboring_window down";
        "ctrl+s>q" = "focus_visible_window";

        # move panes
        "ctrl+s>ctrl+k" = "move_window up";
        "ctrl+s>ctrl+h" = "move_window left";
        "ctrl+s>ctrl+l" = "move_window right";
        "ctrl+s>ctrl+j" = "move_window down";

        # manipulate panes
        "ctrl+s>ctrl+r" = "start_resizing_window";
        "ctrl+s>r" = "layout_action rotate";
        "ctrl+s>x" = "close_window";

        # open ui panel to move the pane somewhere else
        "ctrl+s>m" = "detach_window ask";

        # show index for easier switching, show number of panes
        "ctrl+s>c" = "launch --type=tab --cwd=current";
        "ctrl+s>n" = "next_tab";
        "ctrl+s>p" = "previous_tab";
        "ctrl+s>1" = "goto_tab 1";
        "ctrl+s>2" = "goto_tab 2";
        "ctrl+s>3" = "goto_tab 3";
        "ctrl+s>4" = "goto_tab 4";
        "ctrl+s>5" = "goto_tab 5";
        "ctrl+s>6" = "goto_tab 6";
        "ctrl+s>7" = "goto_tab 7";
        "ctrl+s>8" = "goto_tab 8";
        "ctrl+s>9" = "goto_tab 9";
        "ctrl+s>0" = "goto_tab -1";

        "super+1" = "goto_tab 1";
        "super+2" = "goto_tab 2";
        "super+3" = "goto_tab 3";
        "super+4" = "goto_tab 4";
        "super+5" = "goto_tab 5";
        "super+6" = "goto_tab 6";
        "super+7" = "goto_tab 7";
        "super+8" = "goto_tab 8";
        "super+9" = "goto_tab 9";
        "super+0" = "goto_tab -1";

        "alt+enter" = "toggle_fullscreen";
      };
    };
  };
}
