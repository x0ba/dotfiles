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
      "1password"
      "appcleaner"
      "brave-browser"
      "bettertouchtool"
      "rectangle"
      "bbedit"
      "discord"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "marta"
      "maccy"
      "raycast"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "mullvad-browser"
      "obsidian"
      "radio-silence"
      "qbittorrent"
      "shottr"
      "skim"
      "tempbox"
      "utm"
      "veracrypt"
      "marta"
      "wacom-tablet"
      "yubico-authenticator"
      (skipSha "spotify")
      (skipSha "hazeover")
      (skipSha "element")
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
