{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isLinux isDarwin;
in {
  config = lib.mkIf config.isGraphical {
    programs.chromium = {
      enable = isLinux;
      package = pkgs.ungoogled-chromium;
    };

    programs.firefox = {
      enable = true;
      package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
      profiles.default = {
        extraConfig = builtins.readFile ./firefox/user.js;
        search = {
          force = true;
          default = "Brave";
          engines."Brave" = {
            urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
          };
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          onetab
          languagetool
          mailvelope
          multi-account-containers
          onepassword-password-manager
          refined-github
          temporary-containers
          ublock-origin
          vimium
        ];
      };
    };

    home.packages = lib.mkIf isLinux [
      pkgs.nur.repos.nekowinston.sizzy
      pkgs.mullvad-browser
    ];

    xdg.mimeApps.defaultApplications = {
      "text/html" = "chromium.desktop";
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";
    };
  };
}
