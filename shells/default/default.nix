{pkgs, ...}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    alejandra
    git
    git-crypt
    just
    nix-output-monitor
    nixd
    nvd
    sops
  ];
}
