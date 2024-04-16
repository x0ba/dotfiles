{pkgs, ...}: {
  home.packages = with pkgs; [
    sqlite
    coreutils-prefixed
    tectonic
    gnuplot
    pandoc
    poppler
    (aspellWithDicts (ds: with ds; [en en-computers en-science]))
    sdcv
    languagetool
  ];
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
    ];
  };
}
