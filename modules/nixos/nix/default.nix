{
  options,
  config,
  pkgs,
  inputs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.nix;
in {
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    system.rebuild.enableNg = true;
    nixpkgs = {
      config.allowUnfree = true;
    };

    nix = let
      users = [
        "@sudo"
        "@wheel"
        "daniel"
        "d"
      ];
    in {
      inherit (cfg) package;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
        ];
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users;
        allowed-users = users;

        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
          "https://ghostty.cachix.org"
          "https://cosmic.cachix.org"
          "https://mic92.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
        ];
      };

      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      gc = {
        automatic = true;
        dates = "weekly";
      };

      optimise = {
        automatic = true;
        dates = ["00:30"];
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
