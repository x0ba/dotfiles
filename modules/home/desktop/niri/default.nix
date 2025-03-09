{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  swayosd-client = "${config.services.swayosd.package}/bin/swayosd-client";
  swayosd-server = "${config.services.swayosd.package}/bin/swayosd-server";

  cfg = config.${namespace}.desktop.niri;
in {
  options.${namespace}.desktop.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    skibidi.apps = {
      rofi.enable = true;
      swaylock.enable = true;
      wlogout.enable = true;
      swayosd.enable = true;
      waybar.enable = true;
      swaync.enable = true;
    };
    skibidi.desktop.services.enable = true;
    programs.ghostty.settings.window-decoration = false;
    xdg.configFile."niri/config.kdl".text =
      # kdl
      ''
        environment {
            DISPLAY ":0"
            QT_QPA_PLATFORM "wayland"
            XDG_CURRENT_DESKTOP "niri"
            XDG_SESSION_TYPE "wayland"
            MANGOHUD "0"
            MANGOHUD_DLSYM "1"
            EDITOR "nvim"
            _JAVA_AWT_WM_NONREPARENTING "1"
            _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=gasp"
        }
        input {
            keyboard {
                xkb {
                    options "compose:ralt,ctrl:nocaps"
                }
                repeat-delay 200
                repeat-rate 40
            }

            touchpad {
                dwt
                dwtp
                tap
                natural-scroll
            }

            trackpoint {
                accel-speed 0.3
            }
        }

        hotkey-overlay {
            skip-at-startup
        }

        output "eDP-1" {
            mode "1920x1080@60"
            scale 1.0
            transform "normal"
            position x=0 y=0
        }

        layout {
            gaps 8

            preset-column-widths {
                proportion 0.25
                proportion 0.5
                proportion 0.75
                proportion 1.0
            }

            default-column-width {}

            focus-ring {
                width 3
                active-color "hsla(232, 97%, 85%, 0.80)"
                inactive-color "hsla(251, 86%, 64%, 0.10)"
            }

            insert-hint {
              color "#b4befe40"
            }
        }


        prefer-no-csd

        screenshot-path "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png"

        window-rule {
            min-height 200
            min-width 200
            geometry-corner-radius 6
            clip-to-geometry true
        }

        window-rule {
            match title=r#"(?i)gmail"#
            match title=r#"(?i)inertia"#
            match title="Signal"

            block-out-from "screen-capture"

            focus-ring {
                on
                width 3
                active-color "#FF8787"
                inactive-color "#FF8787"
            }
        }

        window-rule {
            match is-focused=false title=r#"(?i)gmail"#
            match is-focused=false title=r#"(?i)1Password"#
            match is-focused=false title=r#"(?i)inertia"#
            match is-focused=false title="Signal"

            opacity 0.5
            draw-border-with-background true

            border {
                on
                width 0
                active-color "#000000"
                inactive-color "#000000"
            }
        }

        spawn-at-startup "${lib.getExe pkgs.xwayland-satellite}"
        spawn-at-startup "${lib.getExe pkgs.swaybg}" "-i" "${../wallpapers/man.jpg}"
        spawn-at-startup "${lib.getExe pkgs.waybar}"
        spawn-at-startup "${swayosd-server}"
        spawn-at-startup "sh" "-c" "${lib.getExe pkgs.swayidle} -w timeout 300 'niri msg action power-off-monitors' resume 'niri msg action power-on-monitors' before-sleep '${lib.getExe config.programs.swaylock.package} -f'"
        spawn-at-startup "${pkgs.swaynotificationcenter}/bin/swaync"
        spawn-at-startup "${lib.getExe pkgs.wlsunset}" "-l" "37.4" "-L" "-121.9"

        binds {
            Mod+Shift+Slash { show-hotkey-overlay; }

            Mod+Return { spawn "${lib.getExe pkgs.ghostty}"; }
            Mod+E { spawn "${pkgs.emacs30-pgtk}/bin/emacsclient" "-c"; }
            Mod+V { spawn "sh" "-c" "${lib.getExe pkgs.clipman} pick -t rofi --err-on-no-selection && ${lib.getExe pkgs.wtype} -M ctrl -M shift v"; }
            Mod+Shift+Space { spawn "${lib.getExe pkgs._1password-gui}" "--quick-access"; }
            Mod+D { spawn "${lib.getExe pkgs.rofi-wayland}" "-show" "drun"; }
            Mod+P { spawn "${lib.getExe pkgs.wlogout}"; }
            Super+Alt+L { spawn "${lib.getExe config.programs.swaylock.package}"; }

            XF86AudioRaiseVolume allow-when-locked=true { spawn "${swayosd-client}" "--output-volume" "5"; }
            XF86AudioLowerVolume allow-when-locked=true { spawn "${swayosd-client}" "--output-volume" "-5"; }
            XF86AudioMute allow-when-locked=true { spawn "${swayosd-client}" "--output-volume" "mute-toggle"; }

            XF86AudioNext { spawn "${lib.getExe pkgs.playerctl}" "next"; }
            XF86AudioPrev { spawn "${lib.getExe pkgs.playerctl}" "previous"; }
            XF86AudioPlay { spawn "${lib.getExe pkgs.playerctl}" "play-pause"; }

            Xf86MonBrightnessUp allow-when-locked=true { spawn "${swayosd-client}" "--brightness" "raise"; }
            Xf86MonBrightnessDown allow-when-locked=true { spawn "${swayosd-client}" "--brightness" "lower"; }

            Mod+Q { close-window; }

            Mod+Left  { focus-column-left; }
            Mod+Down  { focus-window-down; }
            Mod+Up    { focus-window-up; }
            Mod+Right { focus-column-right; }
            Mod+H     { focus-column-left; }
            // Mod+J     { focus-window-down; }
            // Mod+K     { focus-window-up; }
            Mod+J     { focus-window-or-workspace-down; }
            Mod+K     { focus-window-or-workspace-up; }
            Mod+L     { focus-column-right; }

            Mod+Ctrl+Left  { move-column-left; }
            Mod+Ctrl+Down  { move-window-down; }
            Mod+Ctrl+Up    { move-window-up; }
            Mod+Ctrl+Right { move-column-right; }
            Mod+Ctrl+H     { move-column-left; }
            // Mod+Ctrl+J     { move-window-down; }
            // Mod+Ctrl+K     { move-window-up; }
            Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
            Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }
            Mod+Ctrl+L     { move-column-right; }

            Mod+Home { focus-column-first; }
            Mod+End  { focus-column-last; }
            Mod+Ctrl+Home { move-column-to-first; }
            Mod+Ctrl+End  { move-column-to-last; }

            Mod+Page_Down      { focus-workspace-down; }
            Mod+Page_Up        { focus-workspace-up; }
            Mod+U              { focus-workspace-down; }
            Mod+I              { focus-workspace-up; }
            Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
            Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
            Mod+Ctrl+U         { move-column-to-workspace-down; }
            Mod+Ctrl+I         { move-column-to-workspace-up; }

            Mod+Shift+Page_Down { move-workspace-down; }
            Mod+Shift+Page_Up   { move-workspace-up; }
            Mod+Shift+U         { move-workspace-down; }
            Mod+Shift+I         { move-workspace-up; }

            Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
            Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
            Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
            Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

            Mod+WheelScrollRight      { focus-column-right; }
            Mod+WheelScrollLeft       { focus-column-left; }
            Mod+Ctrl+WheelScrollRight { move-column-right; }
            Mod+Ctrl+WheelScrollLeft  { move-column-left; }

            Mod+Shift+WheelScrollDown      { focus-column-right; }
            Mod+Shift+WheelScrollUp        { focus-column-left; }
            Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
            Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }
            Mod+Ctrl+1 { move-column-to-workspace 1; }
            Mod+Ctrl+2 { move-column-to-workspace 2; }
            Mod+Ctrl+3 { move-column-to-workspace 3; }
            Mod+Ctrl+4 { move-column-to-workspace 4; }
            Mod+Ctrl+5 { move-column-to-workspace 5; }
            Mod+Ctrl+6 { move-column-to-workspace 6; }
            Mod+Ctrl+7 { move-column-to-workspace 7; }
            Mod+Ctrl+8 { move-column-to-workspace 8; }
            Mod+Ctrl+9 { move-column-to-workspace 9; }

            Mod+Tab { focus-workspace-previous; }

            Mod+Comma  { consume-window-into-column; }
            Mod+Period { expel-window-from-column; }

            Mod+BracketLeft  { consume-or-expel-window-left; }
            Mod+BracketRight { consume-or-expel-window-right; }

            Mod+R { switch-preset-column-width; }
            Mod+Shift+R { switch-preset-window-height; }
            Mod+Ctrl+R { reset-window-height; }
            Mod+F { maximize-column; }
            Mod+Alt+F { toggle-window-floating; }
            Ctrl+Mod+F { fullscreen-window; }
            Mod+C { center-column; }

            Mod+Minus { set-column-width "-10%"; }
            Mod+Equal { set-column-width "+10%"; }

            Mod+Shift+Minus { set-window-height "-10%"; }
            Mod+Shift+Equal { set-window-height "+10%"; }

            Print { spawn "${lib.getExe pkgs.sway-contrib.grimshot}" "copy" "area"; }

            Alt+Print { screenshot; }

            Mod+Shift+E { quit; }

            Mod+Shift+P { power-off-monitors; }
        }
      '';
  };
}
