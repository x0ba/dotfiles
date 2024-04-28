{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "x0ba";
    userEmail = "x0ba@tuta.io";

    signing = {
      signByDefault = true;
      key = "5C5C1EFB439B554A81341B1F20347137CA846F7F";
    };

    delta.enable = true;
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
      "ltex.dictionary*.txt"
      "ltex.disabledRules.*.txt"
      # nix-specific
      ".direnv/"
      ".envrc"
    ];

    extraConfig = {
      credential.helper = "gopass";
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
}
