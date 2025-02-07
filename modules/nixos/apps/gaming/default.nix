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
  cfg = config.${namespace}.apps.gaming;
in {
  options.${namespace}.apps.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable gaming apps.";
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraPackages = with pkgs; [
          corefonts
          mangohud
          wineWowPackages.staging
          winetricks
        ];
      };
      gamemode = {
        enable = true;
        settings = {
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };
    };
    hardware.graphics = {
      enable32Bit = true;
    };
    services.pulseaudio.support32Bit = true;
  };
}
