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
      cascadia-code
      atkinson-hyperlegible
      jetbrains-mono
    ];
  };
}
