{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  imports = [./apps ./secrets ./xdg.nix];

  home = {
    packages = with pkgs; ([
        _1password
        age
        age-plugin-yubikey
        gnused
        deno
        fd
        ffmpeg
        file
        sesh
        gh
        git-crypt
        gocryptfs
        nodejs_20
        imagemagick
        just
        pandoc
        mdcat
        nix-output-monitor
        nvd
        ranger
        ripgrep
        rust-analyzer
        wakatime
        watchexec
      ]
      ++ lib.optionals (config.isGraphical && isLinux) [
        _1password-gui
        nur.repos.nekowinston.uhk-agent
        neovide
      ]);
    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  age.secrets."wakatime.cfg".path = "${config.home.homeDirectory}/.wakatime.cfg";
}
