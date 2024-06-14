{ pkgs, config, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # disable fish greeting
      set fish_greeting
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
    shellAliases = {
      # docker
      d = "docker";
      dp = "podman";

      # git
      g = "git";
      gcl = "git clone";
      gl = "git pull --prune";
      glg = "git log --graph --decorate --oneline --abbrev-commit";
      glga = "glg --all";
      gp = "git push origin HEAD";
      gpa = "git push origin --all";
      gd = "git diff";
      gc = "git commit -s";
      gca = "git commit -sa";
      gco = "git checkout";
      gb = "git branch -v";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit -sm";
      gcam = "git commit -sam";
      gs = "git status -sb";
      glnext = "git log --oneline (git describe --tags --abbrev=0 @^)..@";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      gms = "git switch (git main-branch); and git sync";
      egms = "e; git switch (git main-branch); and git sync";
      gwc = "git switch -c";

      # neovim
      e = "nvim";
      v = "nvim";

      # tmux
      sf = "sesh connect $(sesh list | fzf)";
      sc = "sesh connect";
      s = "sesh";
    };
  };
}
