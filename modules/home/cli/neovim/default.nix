{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.neovim;
in {
  options.${namespace}.cli.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim = enabled;
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/dotfiles/modules/home/cli/neovim/config";
    home = {
      packages = with pkgs; [
        # lua
        stylua
        lua-language-server
        luaPackages.tl
        luaPackages.teal-language-server

        # go
        go
        delve
        ginkgo
        gofumpt
        golangci-lint
        golines
        gomodifytags
        gopls
        gotests
        gotestsum
        gotools
        govulncheck
        iferr
        impl
        mockgen
        reftools
        richgo

        # webdev
        nodePackages."@astrojs/language-server"
        nodePackages."@tailwindcss/language-server"
        nodePackages.alex
        nodePackages.bash-language-server
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.intelephense
        nodePackages.typescript
        nodePackages.typescript-language-server
        vscode-langservers-extracted
        nodePackages.yaml-language-server
        yarn

        # rust
        cargo
        rust-analyzer
        rustc
        rustfmt

        # etc
        alejandra
        nixfmt-rfc-style
        deno
        ltex-ls
        nixd
        nodePackages.prettier
        proselint
        shellcheck
        nodejs_23
        shfmt
        tree-sitter

        # needed for some plugin build steps
        gnumake
        gcc
        unzip
      ];
      sessionVariables = {
        EDITOR = "nvim";
        SUDO_EDITOR = "nvim";
        VISUAL = "nvim";
      };
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";
      };
    };
  };
}
