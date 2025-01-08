{
  options,
  config,
  lib,
  pkgs,
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
    # Enable auto-cpufreq (better than gnomes internal power manager)
    services = {
      # auto-cpufreq = {
      #   enable = true;
      #   settings = {
      #     battery = {
      #       enable_thresholds = true;
      #       start_threshold = 70;
      #       stop_threshold = 80;
      #     };
      #   };
      # };
      power-profiles-daemon.enable = false;
      throttled = {
        enable = true;
        extraConfig = import ./throttled.nix;
      };
    };
  };
}
