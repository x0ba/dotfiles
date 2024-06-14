{ pkgs, ... }:
let
  inherit (pkgs.tmuxPlugins) mkTmuxPlugin;

  menus = mkTmuxPlugin {
    pluginName = "menus";
    version = "unstable-2024-04-09";
    src = pkgs.fetchFromGitHub {
      owner = "jaclu";
      repo = "tmux-menus";
      rev = "66700dd790374d40482d836b3e12e88231da79e6";
      sha256 = "sha256-Q0zVLIQ9f0KTO1Y3gDJU+5CbfnpGeUQhp1OPaml1FuU=";
    };
  };
  themepack = mkTmuxPlugin {
    pluginName = "themepack";
    version = "unstable-2022-12-23";
    src = pkgs.fetchFromGitHub {
      owner = "jimeh";
      repo = "tmux-themepack";
      rev = "7c59902f64dcd7ea356e891274b21144d1ea5948";
      sha256 = "sha256-c5EGBrKcrqHWTKpCEhxYfxPeERFrbTuDfcQhsUAbic4=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = menus;
        extraConfig = ''
          set -g @menus_location_x 'C'
          set -g @menus_location_y 'C'
          set -g @menus_trigger 'm'

          # nix-specific, cache dir would be read-only
          set -g @menus_use_cache 'no'
        '';
      }
      {
        plugin = jump;
        extraConfig = "set -g @jump-key 'f'";
      }
      { plugin = vim-tmux-navigator; }
      {
        plugin = open;
        extraConfig = "set -g @open-S 'https://duckduckgo.com/?q='";
      }
      {
        plugin = urlview;
        extraConfig = "set -g @urlview-key 'u'";
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_status_modules_right "application session"
          set -g @catppuccin_status_modules_left ""
        '';
      }
    ];
    terminal = "tmux-256color";

    mouse = true;

    keyMode = "vi";
    customPaneNavigationAndResize = true;

    extraConfig = ''
      # neovim fixes
      set-option -g terminal-overrides ',xterm-256color:RGB'
      set-option -g focus-events on
      set-option -sg escape-time 10

      # set default shell to fish
      set -g default-shell ${pkgs.fish}/bin/fish
      set -g default-command ${pkgs.fish}/bin/fish

      # some nice settings
      set-option -g focus-events on
      set-option -g display-time 3000
      set -g base-index 1
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 1000000
      set -g mouse on
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-interval 3

      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
      set -g detach-on-destroy off  # don't exit from tmux when closing a session

      # split with | and -
      unbind-key \\
      unbind-key -
      bind-key \\ split-window -h -c "#{pane_current_path}"
      bind-key -  split-window -v -c "#{pane_current_path}"

      # sesh keybinds
      bind-key "K" display-popup -E -w 40% "sesh connect \"$(
        sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh' --prompt='⚡'
      )\""

      # couple of vi mode keybinds
      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # toggle status bar
      bind b set -g status
    '';
  };
}
