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
  cfg = config.${namespace}.system.hardware_acceleration;
in {
  options.${namespace}.system.hardware_acceleration = with types; {
    enable = mkBoolOpt false "Whether or not to manage hardware acceleration.";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        libvdpau-va-gl
        vpl-gpu-rt
        intel-media-driver
      ];
    };
    hardware.intel-gpu-tools.enable = true;
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
