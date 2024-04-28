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
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-macport.override {
      withNativeCompilation = true;
      withSQLite3 = true;
      withTreeSitter = true;
      withWebP = true;
    };
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
    ];
  };
}
