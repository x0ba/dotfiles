{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.brew;
  default-attrs = mapAttrs (_key: mkDefault);
  nested-default-attrs = mapAttrs (_key: default-attrs);
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in {
  options.${namespace}.brew = with types; {
    default-attrs = mapAttrs (_key: mkDefault);
    nested-default-attrs = mapAttrs (_key: default-attrs);
    enable = mkBoolOpt false "Whether or not to manage homebrew apps";
    casks = mkOpt (listOf str) [] "Extra casks to install";
    brews = mkOpt (listOf str) [] "Extra brews to install";
  };

  config = mkIf cfg.enable {
    # make brew available in PATH
    environment.systemPath = [config.homebrew.brewPrefix];

    homebrew = {
      enable = true;
      caskArgs.require_sha = true;
      inherit (cfg) brews;
      casks =
        [
          "1password"
          "raycast"
          "discord"
          "iina"
          "tailscale"
          (skipSha "autodesk-fusion")
          "ghostty"
          "hiddenbar"
          "firefox"
          "syncthing"
          "mullvad-browser"
          "brave-browser"
          "maccy"
          "linearmouse"
          "keka"
          "veracrypt"
          "macfuse"
          "netnewswire"
          "nextcloud"
          "obsidian"
          "yubico-authenticator"
          (skipSha "spotify")
          "rectangle"
          "orion"
          "syntax-highlight"
          "tor-browser"
          "yubico-yubikey-manager"
        ]
        ++ cfg.casks;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
