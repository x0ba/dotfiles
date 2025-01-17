{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.settings;
in {
  options.${namespace}.settings = with types; {
    enable = mkBoolOpt false "Whether or not to manage some basic settings";
  };

  config = mkIf cfg.enable {
    # manipulate the global /etc/zshenv for PATH, etc.
    programs.zsh.enable = true;

    security.pam.enableSudoTouchIdAuth = true;
    system = {
      defaults = {
        loginwindow.LoginwindowText = "Live, laugh, love.";
        dock = {
          show-recents = false;
          autohide = true;
          autohide-delay = 0.0;
          autohide-time-modifier = 0.45;
          showhidden = true;
          tilesize = 48;
        };
        CustomSystemPreferences = {
          NSGlobalDomain = {
            AppleLanguages = [
              "en-US"
            ];
          };
        };
        ".GlobalPreferences"."com.apple.mouse.scaling" = 0.5;
        alf.stealthenabled = 1;
        alf.globalstate = 1;
        NSGlobalDomain = {
          # input
          "com.apple.keyboard.fnState" = false;
          ApplePressAndHoldEnabled = false;
          KeyRepeat = 2;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
      };
      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };
      stateVersion = 4;
    };

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
  };
}
