{inputs, ...}: let
  user = "daniel@phantom";
in {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "phantom";

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      daniel = import ../../../homes/x86_64-linux/${user};
    };
  };

  skibidi = {
    # secrets.enable = true;
    suites = {
      common.enable = true;
      desktop.enable = true;
    };
    apps.gaming.enable = true;
    apps.onepassword.enable = true;
    apps.openssh.enable = true;
    user = {
      name = "daniel";
    };
    system = {
      laptop.enable = true;
    };
    desktop.niri.enable = true;
  };

  system.stateVersion = "24.11";
}
