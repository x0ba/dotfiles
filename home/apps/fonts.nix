{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "JetBrainsMono"];})
      ibm-plex
      sf-mono-liga-bin
      commit-mono
      ia-writer-quattro
      jetbrains-mono
      dejavu_fonts
      iosevka
    ];
  };
}
