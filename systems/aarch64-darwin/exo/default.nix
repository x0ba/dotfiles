{
  lib,
  namespace,
  ...
}:
with lib.${namespace}; {
  networking.hostName = "exo";
  skibidi = {
    nix.enable = true;
    # aerospace.enable = true;
    settings.enable = true;
    brew = {
      enable = true;
      casks = ["prismlauncher"];
    };
  };

  system.stateVersion = 4;
}
