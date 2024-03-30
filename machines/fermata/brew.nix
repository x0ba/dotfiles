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
      "aldente"
      "appcleaner"
      "bettertouchtool"
      "blender"
      "calibre"
      "firefox"
      "iina"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "macfuse"
      "mullvad-browser"
      "obs"
      "obsidian"
      "shottr"
      (skipSha "spotify")
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
