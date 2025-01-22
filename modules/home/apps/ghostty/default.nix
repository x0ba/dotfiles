{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) mkMerge;
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;

  cfg = config.${namespace}.apps.ghostty;

  keybind =
    (builtins.map (i: "alt+${toString i}=unbind") (lib.range 0 9))
    ++ [
      "ctrl+s>c=new_tab"
      "ctrl+s>x=close_surface"
      "ctrl+s>1=goto_tab:1"
      "ctrl+s>2=goto_tab:2"
      "ctrl+s>3=goto_tab:3"
      "ctrl+s>4=goto_tab:4"
      "ctrl+s>5=goto_tab:5"
      "ctrl+s>6=goto_tab:6"
      "ctrl+s>7=goto_tab:7"
      "ctrl+s>8=goto_tab:8"
      "ctrl+s>9=goto_tab:9"
      "ctrl+s>0=goto_tab:10"
      # split navigation
      "ctrl+s>\\=new_split:right"
      "ctrl+s>-=new_split:down"
      "ctrl+s>h=goto_split:left"
      "ctrl+s>j=goto_split:bottom"
      "ctrl+s>k=goto_split:top"
      "ctrl+s>l=goto_split:right"
      "ctrl+s>shift+h=resize_split:left,10"
      "ctrl+s>shift+j=resize_split:down,10"
      "ctrl+s>shift+k=resize_split:up,10"
      "ctrl+s>shift+l=resize_split:right,10"
    ];
in {
  options.${namespace}.apps.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      package =
        if isLinux
        then pkgs.ghostty
        else (pkgs.writeScriptBin "__dummy-ghostty" "");
      settings = mkMerge [
        {
          # appearance
          font-family = "BerkeleyMono Nerd Font";
          font-size = 13;
          theme = "light:catppuccin-latte,dark:catppuccin-mocha";

          inherit keybind;
        }
        (mkIf isLinux {
          adw-toolbar-style = "flat";
          gtk-tabs-location = "bottom";
          gtk-wide-tabs = false;
          window-decoration = false;

          linux-cgroup = "always";
        })
        (mkIf isDarwin {
          macos-auto-secure-input = true;
          macos-icon-frame = "chrome";
        })
      ];
    };
  };
}
