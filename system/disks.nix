{
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  fileSystems = {
    "/boot" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "umask=0077" "noatime" "discard"];
    };

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["size=2G" "mode=755"];
    };

    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["noatime" "discard" "subvol=@nix" "compress=zstd"];
    };

    "/persistent" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["noatime" "discard" "subvol=@persistent" "compress=zstd"];
    };
  };

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/backlight"
      "/var/log"
    ];

    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];

    users.jorlyf = {
      directories = [
        ".ssh"
        ".cache/chromium"
        ".config/chromium"
        ".config/fish"
        ".config/mozilla/firefox"
        ".config/obs-studio"
        ".config/onlyoffice"
        ".config/syncthing"
        ".local/share/containers"
        ".local/share/fish"
        ".local/share/onlyoffice"
        ".local/share/TelegramDesktop"
        ".local/share/zed"
        ".local/state/pipewire"
        ".local/state/wireplumber"
        "persistent"
        "Documents" "Downloads" "Pictures" "Videos"
      ];
    };
  };
}
