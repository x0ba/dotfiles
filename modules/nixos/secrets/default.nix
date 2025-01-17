{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.secrets;
in {
  options.${namespace}.secrets = with types; {
    enable = mkBoolOpt false "Enable secrets";
  };

  config = mkIf cfg.enable {
    sops.defaultSopsFile = ../../../secrets/secrets.yaml;
    sops.age.sshKeyPaths = [
      "/persist/system/home/daniel/.ssh/id_ed25519"
    ];
    sops.age.generateKey = true;
  };
}
