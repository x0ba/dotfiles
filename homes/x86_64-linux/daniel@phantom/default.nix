{pkgs, ...}: {
  home.packages = with pkgs; [
    rnote
    nextcloud-client
    obsidian
    obs-studio
    transmission_4-gtk
    calibre
    pika-backup
    yubioath-flutter
    signal-desktop
    spotify
  ];
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  skibidi = {
    desktop = {
      # gnome.enable = true;
      niri.enable = true;
      fonts.enable = true;
      gtk.enable = true;
    };
    apps = {
      browsers.enable = true;
      discord.enable = true;
      emacs.enable = true;
      media.enable = true;
      ghostty.enable = true;
      spotify.enable = true;
      mpv.enable = true;
      xdg.enable = true;
      vscode.enable = true;
      zed.enable = true;
    };
    user.enable = true;
    cli = {
      home-manager.enable = true;
      zsh.enable = true;
      ssh.enable = true;
      utils.enable = true;
      neovim.enable = true;
      git.enable = true;
      yazi.enable = true;
      gpg.enable = true;
    };
  };
}
