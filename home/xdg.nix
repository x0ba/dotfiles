# assortment of random bs that's needed
# to make apps use XDG directories
{ config, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.xdg) cacheHome configHome dataHome;
  inherit (config.home) homeDirectory;
in
{
  home = rec {
    sessionVariables = {
      AZURE_CONFIG_DIR = "${configHome}/azure";
      BUNDLE_USER_CACHE = "${cacheHome}/bundle";
      BUNDLE_USER_CONFIG = "${configHome}/bundle";
      BUNDLE_USER_PLUGIN = "${dataHome}/bundle";
      CARGO_HOME = "${dataHome}/cargo";
      CUDA_CACHE_PATH = "${dataHome}/nv";
      DENO_INSTALL_ROOT = "${dataHome}/deno";
      DOCKER_CONFIG = "${configHome}/docker";
      STACK_ROOT = "${dataHome}/stack";
      WAKATIME_HOME = "${dataHome}/wakatime";
      GEM_HOME = "${dataHome}/gem";
      GEM_SPEC_CACHE = "${cacheHome}/gem";
      GOPATH = "${dataHome}/go";
      IPYTHONDIR = "${configHome}/ipython";
      NODE_REPL_HISTORY = "${dataHome}/node_repl_history";
      NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
      RUSTUP_HOME = "${dataHome}/rustup";
      W3M_DIR = "${dataHome}/w3m";
      WINEPREFIX = "${dataHome}/wine";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "${dataHome}/krew/bin"
      "${sessionVariables.GOPATH}/bin"
      "${sessionVariables.CARGO_HOME}/bin"
      "${sessionVariables.DENO_INSTALL_ROOT}/bin"
    ];
  };

  programs.gpg.homedir = "${configHome}/gnupg";

  xdg = {
    enable = true;
    userDirs.enable = isLinux;
    cacheHome = "${homeDirectory}/.cache";
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    mimeApps = {
      enable = isLinux;
      defaultApplications = {
        "application/gzip" = "nautilus.desktop";
        "application/vnd.rar" = "nautilus.desktop";
        "application/x-7z-compressed" = "nautilus.desktop";
        "application/x-bzip" = "nautilus.desktop";
        "application/x-bzip2" = "nautilus.desktop";
        "application/x-compressed-tar" = "nautilus.desktop";
        "application/x-tar" = "nautilus.desktop";
        "application/zip" = "nautilus.desktop";
        "inode/directory" = "nautilus.desktop";
      };
    };
  };
}
