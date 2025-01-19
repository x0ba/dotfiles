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
  cfg = config.${namespace}.desktop.niri;
in {
  options.${namespace}.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable or disable the niri window manager.";
  };
  imports = [
    inputs.niri.nixosModules.niri
  ];

  config = mkIf cfg.enable {
    security.pam.services.swaylock = {};

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    programs.dconf.enable = true;
    skibidi.desktop.greeter.enable = true;

    environment.systemPackages = with pkgs; [
      # file management
      nautilus
      nautilus-python
      wl-clipboard
      # thumbnails
      webp-pixbuf-loader
      ffmpegthumbnailer
    ];
    programs.file-roller.enable = true;
    programs.gnome-disks.enable = true;

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };

    environment = {
      sessionVariables = {
        NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
        # session
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "sway";
        XDG_CURRENT_DESKTOP = "sway";
        # wayland
        NIXOS_OZONE_WL = 1;
        MOZ_ENABLE_WAYLAND = 1;
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        _JAVA_AWT_WM_NONREPARENTING = 1;
      };
      pathsToLink = [
        "/share/nautilus-python/extensions"
      ];
    };

    services = {
      # mounting
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
      # previews
      gnome.sushi.enable = true;
      # search metadata
      gnome.localsearch.enable = true;
      # thumbnails
      tumbler.enable = true;
    };
  };
}
