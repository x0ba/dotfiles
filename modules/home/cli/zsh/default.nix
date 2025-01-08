{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv) isLinux;
  zshPlugins = plugins: (map (plugin: rec {
      inherit (src) name;
      inherit (plugin) file src;
    })
    plugins);

  linuxOpen =
    # bash
    ''
      function open() {
        nohup xdg-open "$*" > /dev/null 2>&1
      }
    '';

  cfg = config.${namespace}.cli.zsh;
in {
  options.${namespace}.cli.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      initExtraFirst =
        # bash
        ''
          zvm_config() {
            ZVM_INIT_MODE=sourcing
            ZVM_CURSOR_STYLE_ENABLED=false
            ZVM_VI_HIGHLIGHT_BACKGROUND=black
            ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
            ZVM_VI_HIGHLIGHT_FOREGROUND=white
          }
        '';
      initExtra =
        # bash
        ''
          function incognito() {
            if [[ -n $ZSH_INCOGNITO ]]; then
              add-zsh-hook precmd _atuin_precmd
              add-zsh-hook preexec _atuin_preexec
              unset ZSH_INCOGNITO
            else
              add-zsh-hook -d precmd _atuin_precmd
              add-zsh-hook -d preexec _atuin_preexec
              export ZSH_INCOGNITO=1
            fi
          }

          onefetch_in_git_dir() {
            if [[ -d '.git' ]]; then
              ${pkgs.onefetch}/bin/onefetch --no-merges --no-bots --no-color-palette --true-color=never --text-colors 1 1 3 4 4
            fi
          }

          add-zsh-hook chpwd onefetch_in_git_dir

          ${lib.optionalString isLinux linuxOpen}
        '';
      oh-my-zsh = {
        enable = true;
        plugins =
          [
            "colored-man-pages"
            "colorize"
            "git"
          ]
          ++ lib.optionals pkgs.stdenv.isDarwin [
            "macos"
          ];
      };
      plugins = zshPlugins [
        {
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];
      sessionVariables = {
        MANPAGER = "${lib.getExe pkgs.neovim} +Man!";
      };
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        ll = "${pkgs.eza}/bin/eza -l";
        la = "${pkgs.eza}/bin/eza -a";
        lt = "${pkgs.eza}/bin/eza -T";
        lla = "${pkgs.eza}/bin/eza -la";
        llt = "${pkgs.eza}/bin/eza -lT";

        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
      };
      history.path = "${config.xdg.configHome}/zsh/history";
    };
  };
}
