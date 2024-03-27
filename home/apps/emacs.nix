{pkgs, ...}: {
  home.packages = with pkgs; [
    sqlite
    tectonic
    gnuplot
    pandoc
    (aspellWithDicts (ds: with ds; [en en-computers en-science]))
    sdcv
    languagetool
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-macport;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };
}
