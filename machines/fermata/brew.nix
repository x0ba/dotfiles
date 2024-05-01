{config, ...}: let
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
in {
  # make brew available in PATH
  environment.systemPath = [config.homebrew.brewPrefix];

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    brews = [
      "podman"
      "podman-compose"
    ];
    casks = [
      "1password"
      "alt-tab"
      "appcleaner"
      "bettertouchtool"
      "dropzone"
      "hiddenbar"
      "iina"
      "imageoptim"
      "jetbrains-toolbox"
      "shottr"
      "stats"
      "keka"
      "flux"
      "linearmouse"
      "mac-mouse-fix"
      "monitorcontrol"
      "mullvad-browser"
      "numi"
      "obsidian"
      "orion"
      "skim"
      "tempbox"
      "todoist"
      "veracrypt"
      "wacom-tablet"
      "yubico-authenticator"
      "zed"
      (skipSha "soundsource")
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
