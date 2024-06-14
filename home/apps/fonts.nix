{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.isGraphical {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ibm-plex
      iosevka
      terminus_font_ttf
      cascadia-code
      atkinson-hyperlegible
      jetbrains-mono
    ];
  };
}
