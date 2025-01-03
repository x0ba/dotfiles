{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.rofi;
in {
  options.${namespace}.apps.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Inter 14";
      extraConfig.icon-theme = config.gtk.iconTheme.name;
      terminal = "ghostty";
      theme = "custom";
    };
    home.file.".local/share/rofi/themes/custom.rasi".text =
      # rasi
      ''
        * {
          bg-col:  #1e1e2e;
          bg-col-light: #313244;
          border-col: #b4befe;
          selected-col: #cdd6f4;
          blue: #b4befe;
          fg-col: #cdd6f4;
          gray: #9399b2;
        }

        element-text, element-icon, mode-switcher {
           background-color: inherit;
           text-color:       inherit;
        }

        window {
          height: 360px;
          border: 3px;
          border-color: @border-col;
          background-color: @bg-col;
        }

        mainbox {
          background-color: @bg-col;
        }

        inputbar {
          children: [prompt, entry];
          background-color: @bg-col;
          border-radius: 5px;
          padding: 2px;
        }

        prompt {
          background-color: @blue;
          padding: 6px;
          text-color: @bg-col;
          margin: 20px 0px 0px 20px;
        }

        textbox-prompt-colon {
          expand: false;
          str: ":";
        }

        entry {
          padding: 6px;
          margin: 20px 0px 0px 10px;
          text-color: @fg-col;
          background-color: @bg-col;
        }

        listview {
          border: 0px 0px 0px;
          padding: 6px 0px 0px;
          margin: 10px 0px 0px 20px;
          columns: 2;
          lines: 5;
          background-color: @bg-col;
        }

        element {
          padding: 5px;
          background-color: @bg-col;
          text-color: @fg-col;
        }

        element-icon {
          size: 25px;
        }

        element selected {
          background-color:  @selected-col;
          text-color: @bg-col;
        }

        mode-switcher {
          spacing: 0;
        }

        button {
          padding: 10px;
          background-color: @bg-col-light;
          text-color: @gray;
          vertical-align: 0.5;
          horizontal-align: 0.5;
        }

        button selected {
          background-color: @bg-col;
          text-color: @blue;
        }

        message {
          background-color: @bg-col-light;
          margin: 2px;
          padding: 2px;
          border-radius: 5px;
        }

        textbox {
          padding: 6px;
          margin: 20px 0px 0px 20px;
          text-color: @blue;
          background-color: @bg-col-light;
        }
      '';
  };
}
