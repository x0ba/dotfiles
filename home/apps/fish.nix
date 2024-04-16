_: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      cat = "bat";

      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lt = "eza -T";
      lla = "eza -la";
      llt = "eza -lT";

      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";

      # switch between yubikeys for the same GPG key
      switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';

      # podman
      docker = "podman";
      docker-compose = "podman-compose";
    };
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };
}
