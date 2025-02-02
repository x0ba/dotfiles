{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.greeter;
in {
  options.${namespace}.desktop.greeter = with types; {
    enable = mkBoolOpt false "Whether or not to enable greeter";
  };

  config = mkIf cfg.enable {
    programs.regreet = {
      enable = true;

      font = {
        name = "Inter";
        size = 16;
        package = pkgs.inter;
      };

      cursorTheme = {
        name = "Yaru";
        package = pkgs.yaru-theme;
      };
      iconTheme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      theme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };

      settings.background = {
        path = ../../../home/desktop/wallpapers/blahaj-blue.png;
        fit = "Cover";
      };
    };

    security = {
      pam.services.greetd = {
        enableGnomeKeyring = true;
        u2fAuth = true;
      };
      polkit.enable = true;
      soteria.enable = true;
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
