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
      "bettertouchtool"
      "discord@canary"
      "firefox"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "mullvad-browser"
      "obsidian"
      "lulu"
      "qbittorrent"
      "shottr"
      "skim"
      "tempbox"
      "utm"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      (skipSha "spotify")
      (skipSha "element")
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
