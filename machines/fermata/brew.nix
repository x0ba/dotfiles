{config, ...}: let
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
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
      "blender"
      "brave-browser"
      "calibre"
      (noQuarantine "easy-move-plus-resize")
      (skipSha "hazeover")
      (noQuarantine "hiddenbar")
      "iina"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "macfuse"
      "mullvad-browser"
      "obs"
      "obsidian"
      "raycast"
      "rectangle"
      "stats"
      (skipSha "spotify")
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      "zotero"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
