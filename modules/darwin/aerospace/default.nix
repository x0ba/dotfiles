{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.aerospace;
in {
  options.${namespace}.aerospace = with types; {
    enable = mkBoolOpt false "aerospace";
  };

  config = mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./aerospace.toml);
    };
  };
}
