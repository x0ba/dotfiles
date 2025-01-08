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
    xdg.configFile = {
      "nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink ./config/init.lua;
      "nvim/lua".source = config.lib.file.mkOutOfStoreSymlink ./config/lua;
      "nvim/plugin".source = config.lib.file.mkOutOfStoreSymlink ./config/plugin;
    };
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
        nodePackages.graphql
        nodePackages.graphql-language-service-cli
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
