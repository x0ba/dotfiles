{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.onepassword;
in {
  options.${namespace}.apps.onepassword = with types; {
    enable = mkBoolOpt false "Whether or not to enable 1password.";
  };

  config = mkIf cfg.enable {
    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          .zen-wrapped
        '';
        mode = "0755";
      };
    };
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = ["daniel"];
      };
    };
  };
}
