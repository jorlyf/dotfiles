{
  ...
}:
{
  # На этом же диске стоит Windows, поэтому disko пока что не подходит.

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-label/NIXCRYPT";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems = {
    "/boot" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [
        "umask=0077"
        "noatime"
        "discard"
      ];
    };

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=2G"
        "mode=755"
      ];
    };

    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard"
        "subvol=@nix"
        "compress=zstd"
      ];
    };

    "/persistent" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard"
        "subvol=@persistent"
        "compress=zstd"
      ];
    };
  };
}
