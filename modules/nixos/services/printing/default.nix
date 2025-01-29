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
  cfg = config.${namespace}.services.printing;
in {
  options.${namespace}.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to enable printing support.";
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [pkgs.hplip];
    };
  };
}
