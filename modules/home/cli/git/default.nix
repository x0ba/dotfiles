{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  inherit (pkgs.stdenv) isDarwin;

  cfg = config.${namespace}.cli.git;
in {
  options.${namespace}.cli.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.git-credential-oauth
      pkgs.hub
      pkgs.git-crypt
    ];

    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme = {};
      };
    };

    # disable loading the systme config on Darwin, where Nix tells it to use the
    # osxkeychain credential manager.
    home.sessionVariables = lib.mkIf isDarwin {
      GIT_CONFIG_NOSYSTEM = 1;
    };

    programs.git = {
      enable = true;
      userName = "daniel";
      userEmail = "danielxu0307@proton.me";

      signing = {
        signByDefault = true;
        key = "0x660DBDE129F4E1D9";
      };

      diff-so-fancy.enable = true;
      aliases = {
        # get plain text diffs for patches
        patch = "!git --no-pager diff --no-color";
        # zip the current repo
        gzip = "!git archive --format=tar.gz --output=$(basename $(git rev-parse --show-toplevel)).tar.gz $(git rev-parse --short HEAD)";
        zip = "!git archive --format=zip --output=$(basename $(git rev-parse --show-toplevel)).zip $(git rev-parse --short HEAD)";
        # for those 3am commits
        yolo = "!git commit -m \"chore: $(curl -s https://whatthecommit.com/index.txt)\"";
      };

      lfs.enable = true;

      ignores = [
        # general
        "*.log"
        ".DS_Store"
        # editors
        "*.swp"
        ".gonvim/"
        ".idea/"
        "ltex.*.txt"
        # nix-specific
        ".direnv/"
        ".envrc"
      ];

      extraConfig = {
        credential.helper = [
          "cache --timeout 21600"
          "oauth"
        ];
        init.defaultBranch = "main";
        push.default = "current";
        push.gpgSign = "if-asked";
        rebase.autosquash = true;
        url = {
          "https://github.com/".insteadOf = "gh:";
          "https://github.com/x0ba/".insteadOf = "x0ba:";
          "https://gitlab.com/".insteadOf = "gl:";
        };
      };
    };
  };
}
