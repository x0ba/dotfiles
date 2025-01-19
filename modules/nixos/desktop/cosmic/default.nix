{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.cosmic;
in {
  options.${namespace}.desktop.cosmic = with types; {
    enable = mkBoolOpt false "Enable or disable the cosmic desktop environment";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = [skibidi.cosmic-ext-alt];
    };

    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
