{
  options,
  config,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.impermanence;
in {
  imports = with inputs; [
    impermanence.nixosModules.impermanence
  ];
  options.${namespace}.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
    removeTmpFilesOlderThan = mkOpt int 14 "Number of days to keep old btrfs_tmp files";
  };

  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;
    # This script does the actual wipe of the system
    # So if it doesn't run, the btrfs system effectively acts like a normal system
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = [
        "initrd.target"
      ];
      before = [
        "sysroot.mount"
      ];
      wants = ["dev-root_vg-root.device"];
      after = ["dev-root_vg-root.device"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir /btrfs_tmp
        mount /dev/root_vg/root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${builtins.toString cfg.removeTmpFilesOlderThan}); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
    boot.initrd.services.lvm.enable = true;
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
      users.daniel = {
        files = [
          ".local/share/clipman.json"
        ];
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Code"
          "Nextcloud"
          ".config/Nextcloud"
          ".local/state/syncthing"
          ".config/1Password"
          ".config/spotify"
          ".config/doom"
          ".config/pika-backup"
          ".mullvad"
          ".config/BraveSoftware"
          ".config/emacs"
          ".config/obsidian"
          ".local/share/nvim"
          ".mozilla/firefox"
          ".local/state/nvim"
          ".local/share/atuin"
          ".local/share/zoxide"
          ".local/share/direnv"
          ".cache/tealdeer"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
        ];
      };
    };
  };
}
