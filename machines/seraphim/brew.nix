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
      "bbedit"
      "bettertouchtool"
      "brave-browser"
      "calibre"
      "dropzone"
      "lulu"
      "grandperspective"
      "hyperkey"
      "mac-mouse-fix"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "keka"
      "keyboard-maestro"
      "middleclick"
      "knockknock"
      "jan"
      "latest"
      "linearmouse"
      "mullvad-browser"
      "intellidock"
      "netnewswire"
      "notion-calendar"
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
