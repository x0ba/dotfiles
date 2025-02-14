{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  sharedGtkSettings = {
    gtk-decoration-layout = ":menu";
    gtk-enable-event-sounds = true;
    gtk-enable-input-feedback-sounds = true;
    gtk-sound-theme-name = "Yaru";
  };
  cfg = config.${namespace}.desktop.gtk;
in {
  options.${namespace}.desktop.gtk = {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      name = "Yaru";
      package = pkgs.yaru-theme;
      gtk.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.20;
      };
    };

    gtk = {
      enable = true;
      font.name = "Inter";
      iconTheme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      theme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk3.extraConfig = sharedGtkSettings;
      gtk4.extraConfig = sharedGtkSettings;
    };
    dconf.settings = {
      "org/gnome/desktop/sound" = {
        event-sounds = true;
        input-feedback-sounds = true;
        theme-name = "Yaru";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":appmenu";
      };
    };
    # don't want stuff that doesn't use XDG specs
    home.file = {
      ".icons/default/index.theme".enable = false;
      ".icons/${config.gtk.iconTheme.name}".enable = false;
    };
  };
}
