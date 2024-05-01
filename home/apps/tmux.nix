{pkgs, ...}: let
  tokyo-night-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
    rtpFilePath = "tokyo-night.tmux";
    version = "1.5";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "08017465a0cbe0ee5255369a4b7837cb3bab809e";
      sha256 = "sha256-RFQWX1eG2h0iFbF5OtZJLSbHPXNI8TH+qs1/685+1lc=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf;
    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style none
        '';
      }
    ];
  };

  programs.fish.interactiveShellInit = ''
    # traps the shell quit and switch to the last session if it's the last pane
    # if last session is not available anymore, switch to default
    function __trap_exit_tmux
        test (tmux list-windows | count) = 1 || exit
        test (tmux list-panes | count) = 1 || exit
        tmux switch-client -l || tmux switch-client -t default
    end

    if set -q TMUX
        trap __trap_exit_tmux EXIT
    end
  '';
}
