{ ... }:
{
  imports = [ ./options.nix ];

  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;

  system.stateVersion = 4;
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.alf.stealthenabled = 1;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
