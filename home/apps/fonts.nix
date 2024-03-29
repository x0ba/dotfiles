{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.isGraphical {
    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      fira-code
      ibm-plex
    ];
  };
}
