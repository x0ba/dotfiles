{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.waybar;
in {
  options.${namespace}.apps.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 32;
          spacing = 7;
          fixed-center = false;
          margin-left = null;
          margin-top = null;
          margin-bottom = null;
          margin-right = null;
          exclusive = true;
          modules-left = [
            "custom/search"
            "niri/workspaces"
            "backlight"
            "battery"
            "idle_inhibitor"
          ];
          modules-right = ["pulseaudio" "network" "clock"];

          "custom/search" = {
            format = "";
            tooltip = false;
            on-click = "${lib.getExe pkgs.rofi-wayland} -show drun";
          };

          "custom/power" = {
            tooltip = false;
            # TODO
            format = "󰐥";
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
          };

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "󰔟";
            };
          };

          bluetooth = {
            on-click = ''
              bash -c 'bluetoothctl power $(bluetoothctl show | grep -q "Powered: yes" && echo off || echo on)'
            '';
          };
          backlight = {
            format = "{icon} {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };
          cpu = {
            interval = 5;
            format = "  {}%";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󰂄 {capacity}%";
            format-alt = "{icon}";
            format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          pulseaudio = {
            scroll-step = 5;
            tooltip = true;
            on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
            format = "{icon}  {volume}%";
            format-muted = "󰝟 ";
            format-bluetooth = "󰂯";
            format-icons = {
              default = ["" "" " "];
            };
          };
          network = let
            nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          in {
            format-wifi = "󰤨 {essid}";
            format-ethernet = "󰈀";
            format-alt = "󱛇";
            format-disconnected = "󰤭";
            tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
            on-click-right = "${nm-editor}";
          };
          "niri/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            active-only = false;
            format-icons = {
              default = "";
              active = "";
            };
          };
        }
      ];
      style =
        # css
        ''
          * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: Material Design Icons, Inter, JetBrainsMono Nerd Font;
          }

          window#waybar {
            background-color: #1e1e2e;
            color: #cdd6f4;
            opacity: 0.9;
          }
          window#waybar>box {
           padding: 1px 5px;
          }

          window#waybar.hidden {
            opacity: 0.2;
          }


          .module{
            padding: 0px 8px;
          }

          #workspaces button {
            background-color: transparent;
            padding-left: 6px;
            margin: 0px 7px;
            font-family: JetBrainsMono Nerd Font;
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
            color: #cdd6f4;
          }

          #workspaces button.urgent {
            color: #f38ba8;
          }

          #clock {
            font-weight: 700;
            font-size: 15px;
            font-family: "Iosevka Term";
          }

          #battery.warning {
            color: #f38ba8;
            background-color: inherit;
          }

          #battery.critical:not(.charging) {
            color: #eba0ac;
            background-color: inherit;
          }
          tooltip {
            font-family: 'Inter', sans-serif;
            border-radius: 15px;
            padding: 20px;
            margin: 30px;
          }
          tooltip label {
            font-family: 'Inter', sans-serif;
            padding: 20px;
          }
        '';
    };
  };
}
