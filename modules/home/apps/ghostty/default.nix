{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.apps.ghostty;
in {
  options.${namespace}.apps.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      package =
        if isLinux
        then pkgs.ghostty
        else (pkgs.writeScriptBin "__dummy-ghostty" "");
      enableZshIntegration = true;
      installBatSyntax = false;
      settings = {
        font-size =
          if isLinux
          then 11
          else 13;
        font-family = "BerkeleyMono Nerd Font";

        theme = "catppuccin-mocha";
        confirm-close-surface = false;

        gtk-single-instance = true;
        keybind = "global:ctrl+grave_accent=toggle_quick_terminal";

        window-padding-x = "7";
        window-padding-y = "7";
      };
    };
  };
}
