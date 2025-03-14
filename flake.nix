{
  description = "skibidi dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/nur";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      snowfall = {
        namespace = "skibidi";

        meta = {
          name = "skibidi-flake";
          title = "skibidi Flake";
        };
      };

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
      ];

      systems.modules.nixos = with inputs; [
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
      ];

      systems.hosts.cedar.modules = with inputs; [
        nixos-hardware.nixosModules.lenovo-thinkpad-t480
        (import ./disks/default.nix {
          inherit lib;
          device = "/dev/nvme0n1";
        })
      ];

      outputs-builder = channels: let
        treefmtConfig = _: {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            actionlint.enable = true;
            mdformat.enable = true;
            statix.enable = true;
            deadnix.enable = true;
            just.enable = true;
            stylua.enable = true;
            toml-sort.enable = true;
            jsonfmt.enable = true;
          };
        };
        treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs treefmtConfig;
      in {
        formatter = treefmtEval.config.build.wrapper;
      };

      overlays = [
        inputs.nix-vscode-extensions.overlays.default
        inputs.niri.overlays.niri
        inputs.emacs-overlay.overlays.default
        inputs.catppuccin-vsc.overlays.default
        (final: _prev: {
          nur = import inputs.nur {
            nurpkgs = final;
            pkgs = final;
          };
        })
      ];
    };
}
