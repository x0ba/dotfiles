{config, ...}: let
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in {
  # make brew available in PATH
  environment.systemPath = [config.homebrew.brewPrefix];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    casks = [
      "appcleaner"
      "alt-tab"
      "bitwarden"
      "bettertouchtool"
      "blender"
      "boop"
      "discord"
      "firefox"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "keka"
      "linearmouse"
      "macfuse"
      "mullvad-browser"
      "mullvadvpn"
      "netnewswire"
      "obs"
      "obsidian"
      "pictogram"
      "radio-silence"
      "raycast"
      "stats"
      "shottr"
      (skipSha "spotify")
      "qbittorrent"
      "veracrypt"
      "wacom-tablet"
      "whisky"
      "yubico-authenticator"
      "zed"
      "zotero"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
