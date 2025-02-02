{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv) isLinux;

  cfg = config.${namespace}.apps.discord;
in {
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkIf isLinux [pkgs.discord pkgs.discover-overlay];
  };
}
