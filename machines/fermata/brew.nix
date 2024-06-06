{ config, ... }:
let
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
in
{
  # make brew available in PATH
  environment.systemPath = [ config.homebrew.brewPrefix ];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    brews = [ "podman" ];
    casks = [
      "1password"
      "appcleaner"
      "bettertouchtool"
      "brave-browser"
      "dropzone"
      "grandperspective"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "keka"
      "keyboard-maestro"
      "latest"
      "linearmouse"
      "lulu"
      "marta"
      "mullvad-browser"
      "obsidian"
      "protonvpn"
      "qbittorrent"
      "raycast"
      "shottr"
      "tailscale"
      "todoist"
      "tor-browser"
      "utm"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      (skipSha "spotify")
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
