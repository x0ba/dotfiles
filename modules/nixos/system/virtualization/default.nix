{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.virtualization;
in {
  options.${namespace}.system.virtualization = with types; {
    enable = mkBoolOpt false "Whether or not to manage virtualization settings.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
      podman = {
        enable = true;
        extraPackages = with pkgs; [
          podman-compose
          podman-tui
        ];
      };
    };
    users.users."daniel".extraGroups = [
      "libvirtd"
    ];
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      virtiofsd
      distrobox
    ];
  };
}
