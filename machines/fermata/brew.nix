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
    brews = [
      "podman"
      "podman-compose"
    ];
    casks = [
      "appcleaner"
      "arc"
      "bettertouchtool"
      "bitwarden"
      "discord"
      "grandperspective"
      "hazeover"
      "hiddenbar"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "mullvad-browser"
      "notion"
      "notion-calendar"
      "obsidian"
      "qbittorrent"
      "raycast"
      "shottr"
      "todoist"
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
