{ pkgs, ... }:
let
  srcs = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  home = {
    packages = [ pkgs.onefetch ];
    sessionVariables = {
      LESS = "-R --use-color";
      LESSHISTFILE = "-";
    };
    shellAliases = {
      # switch between yubikeys for the same GPG key
      switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';

      # podman
      docker = "podman";
      docker-compose = "podman-compose";
    };
  };

  programs = {
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        inline_height = 30;
        style = "compact";
        sync_frequency = "5m";
      };
    };
    bat.enable = true;

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group"
        "--group-directories-first"
        "--no-permissions"
        "--octal-permissions"
      ];
    };

    fzf = {
      enable = true;
      defaultOptions = [
        "--height=30%"
        "--layout=reverse"
        "--info=inline"
      ];
    };

    less.enable = true;

    nix-index-database.comma.enable = true;

    starship = {
      enable = true;
      settings = {
        command_timeout = 3000;
        format = "$username$hostname$nix_shell$character";
        right_format = "$directory$git_branch$git_commit$git_state$git_status";

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vimcmd_symbol = "[](bold purple)";
          vimcmd_replace_symbol = "[](bold green)";
          vimcmd_replace_one_symbol = "[](bold green)";
          vimcmd_visual_symbol = "[](bold yellow)";
        };

        username = {
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = "";
          format = "at [$hostname](bold blue) ";
          disabled = false;
        };

        git_commit.format = ''( [\($hash$tag\)]($style))'';
        git_state.format = " [\\($state( $progress_current/$progress_total)\\)]($style)";

        git_status = {
          ahead = "↑";
          behind = "↓";
          conflicted = "±";
          deleted = "×";
          diverged = "↕";
          modified = "‼";
          renamed = "≡";
          stashed = "⌂";
          format = ''( [\[$all_status$ahead_behind\]]($style))'';
        };

        git_branch = {
          format = " → [$symbol$branch(:$remote_branch)]($style)";
          symbol = "";
        };

        battery.disabled = true;
        line_break.disabled = true;

        directory = {
          read_only = "(ro)";
          format = "[$read_only]($read_only_style) [$path]($style)";
        };

        nix_shell.format = "[(\\($name\\))]($style) ";
      };
    };

    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };

    zoxide.enable = true;
  };
}
