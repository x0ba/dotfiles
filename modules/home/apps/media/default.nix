{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.media;
in {
  options.${namespace}.apps.media = {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    programs.imv.enable = true;
    programs.mpv.enable = true;
    programs.zathura.enable = true;

    home.packages = [pkgs.supersonic-wayland];

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "zathura.desktop";
      "image/gif" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
    };
  };
}
