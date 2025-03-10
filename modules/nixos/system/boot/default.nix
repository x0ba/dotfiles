{
  options,
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.boot;
in {
  options.${namespace}.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      initrd.systemd.enable = true;

      plymouth = {
        enable = true;
        themePackages = [pkgs.plymouth-blahaj-theme];
        theme = "blahaj";
      };
    };
  };
}
