{inputs}: [
  inputs.swayfx.overlays.default
  inputs.nix-vscode-extensions.overlays.default
  (final: prev: {
    yabai = prev.yabai.overrideAttrs (old: rec {
      version = "6.0.5";
      src = prev.fetchzip {
        url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
        hash = "sha256-wPJZnnCCaqyNB+Wbw+7LqUdgpwzs0vvZYi7XZp/G8qY=";
      };
    });
    nur = import inputs.nur {
      nurpkgs = prev;
      pkgs = prev;
      repoOverrides = {
        x0ba = import inputs.x0ba-nur {inherit (prev) pkgs;};
        caarlos0 = import inputs.caarlos0-nur {
          inherit (prev) pkgs;
          overlays = [
            (final: prev: {
              discord-applemusic-rich-presence = prev.discord-applemusic-rich-presence.overrideAttrs {
                patches = [./patches/discord-applemusic-rich-presence.patch];
              };
            })
          ];
        };
      };
    };
  })
]
