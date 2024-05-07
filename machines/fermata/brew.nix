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
      "rectangle"
      "firefox"
      "karabiner-elements"
      "hammerspoon"
      "iina"
      "imageoptim"
      "shottr"
      "jetbrains-toolbox"
      "keka"
      "linearmouse"
      "mullvad-browser"
      "hiddenbar"
      "obsidian"
      "skim"
      "tempbox"
      "todoist"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      "utm"
      "zed"
      (skipSha "soundsource")
      (skipSha "spotify")
      (skipSha "element")
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
