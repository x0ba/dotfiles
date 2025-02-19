{
  lib,
  inputs,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkEnableOption mkIf;

  fontDirectory =
    if pkgs.stdenv.isDarwin
    then "${config.home.homeDirectory}/Library/Fonts"
    else "${config.xdg.dataHome}/fonts";
  fontPath = ./fonts;

  cfg = config.${namespace}.desktop.fonts;
in {
  options.${namespace}.desktop.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = isLinux;
      defaultFonts = {
        sansSerif = ["Inter"];
        serif = ["IBM Plex Serif"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Twitter Color Emoji"];
      };
    };
    home.activation.installCustomFonts =
      inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] # bash

      ''
        mkdir -p "${fontDirectory}"
        install -Dm644 ${fontPath}/* "${fontDirectory}"
      '';

    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.blex-mono
      nerd-fonts.intone-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      nerd-fonts.symbols-only
      nerd-fonts.victor-mono
      material-design-icons
      julia-mono
      departure-mono
      iosevka
      ibm-plex
      inter
      monaspace
      twitter-color-emoji
      recursive
    ];
  };
}
