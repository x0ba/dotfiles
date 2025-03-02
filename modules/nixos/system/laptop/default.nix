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
  cfg = config.${namespace}.system.laptop;
in {
  options.${namespace}.system.laptop = with types; {
    enable = mkBoolOpt false "Whether or not to enable laptop optimizations and utils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      powertop
      s-tui
    ];
    services = {
      thermald.enable = true;
      power-profiles-daemon.enable = false;
      throttled = {
        enable = true;
        extraConfig = import ./throttled.nix;
      };
    };
  };
}
