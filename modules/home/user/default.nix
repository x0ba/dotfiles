{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit
    (lib)
    types
    mkIf
    mkDefault
    mkMerge
    ;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;
  is-darwin = pkgs.stdenv.isDarwin;

  home-directory =
    if cfg.name == null
    then null
    else if is-darwin
    then "/Users/${cfg.name}"
    else "/home/${cfg.name}";
in {
  options.${namespace}.user = {
    enable = mkOpt types.bool true "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) (
      config.snowfallorg.user.name or "daniel"
    ) "The user account.";

    fullName = mkOpt types.str "Daniel Xu" "The full name of the user.";
    email = mkOpt types.str "danielxu0307@proton.me" "The email of the user.";

    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "skibidi.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "skibidi.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
