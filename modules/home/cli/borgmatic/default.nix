{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli.borgmatic;
in {
  options.${namespace}.cli.borgmatic = {
    enable = mkEnableOption "borgmatic";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      borgmatic
    ];
    services.borgmatic = {
      enable = true;
      frequency = "daily";
    };
  };
}
