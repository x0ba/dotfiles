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
      "alt-tab"
      "appcleaner"
      "arc"
      "brave-browser"
      "bettertouchtool"
      "discord"
      "hiddenbar"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keka"
      "linearmouse"
      "maccy"
      "macfuse"
      "mullvad-browser"
      "mullvadvpn"
      "netnewswire"
      "obsidian"
      "orion"
      "radio-silence"
      "raycast"
      "shottr"
      "ticktick"
      "tor-browser"
      "veracrypt"
      "wacom-tablet"
      "whisky"
      "yubico-authenticator"
      "zed"
      "zotero"
      (skipSha "element")
      (skipSha "soundsource")
      (skipSha "spotify")
    ];
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
