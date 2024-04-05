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
      "1password"
      "appcleaner"
      "bettertouchtool"
      "blender"
      "calibre"
      "firefox"
      (skipSha "hazeover")
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "lulu"
      "macfuse"
      "mullvad-browser"
      "netnewswire"
      "obs"
      "obsidian"
      "onyx"
      "orion"
      "raycast"
      "shottr"
      "spaceid"
      (skipSha "spotify")
      "ticktick"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      "zotero"
    ];
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
