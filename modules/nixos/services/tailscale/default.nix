{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.tailscale;
in {
  options.${namespace}.services.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to enable tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
