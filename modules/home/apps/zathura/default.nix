{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.zathura;
in {
  options.${namespace}.apps.zathura = {
    enable = mkEnableOption "zathura";
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
    xdg.mimeApps.defaultApplications = lib.genAttrs [
      "application/pdf"
    ] (_: "org.pwmt.zathura.desktop");
  };
}
