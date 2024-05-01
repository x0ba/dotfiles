{
  lib,
  pkgs,
  ...
}: {
  imports = [./options.nix];
  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user
    sudo chsh -s ${pkgs.fish}/bin/fish daniel
  '';

  system.stateVersion = 4;
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.alf.stealthenabled = 1;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services = {
    yabai = {
      enable = false;
      enableScriptingAddition = true;
      logFile = "/var/tmp/yabai.log";
      config = {
        auto_balance = "off";
        focus_follows_mouse = "off";
        layout = "bsp";
        mouse_drop_action = "swap";
        mouse_follows_focus = "off";
        window_animation_duration = "0.0";
        window_gap = 5;
        left_padding = 5;
        right_padding = 5;
        top_padding = 5;
        bottom_padding = 5;
        window_origin_display = "default";
        window_placement = "second_child";
        window_shadow = "float";
      };
      extraConfig = let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in ''
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        ${ignored ["JetBrains Toolbox" "ProtonVPN" "Sip" "Stats"]}
        ${unmanaged ["Godot" "GOG Galaxy" "Steam" "System Settings"]}
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

        # etc.
        ${rule} manage=off app="CleanShot"
        ${rule} manage=off sticky=on  app="OBS Studio"
      '';
    };
    skhd = {
      enable = false;
      skhdConfig = let
        mapKeymaps = with builtins;
          cmd:
            concatStringsSep "\n" (map (i:
              replaceStrings ["Num"] [
                (toString (
                  if (i == 10)
                  then 0
                  else i
                ))
              ]
              cmd) (lib.range 1 10));
      in ''
        #!/usr/bin/env sh
        cmd + shift - return : open -na WezTerm
      '';
    };
  };
}
