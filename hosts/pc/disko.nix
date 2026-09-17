{ ... }:
{
  disko.devices = {
    nodev."/" = {
      type = "nodev";
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "mode=755"
      ];
    };

    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "NIXBOOT";
              name = "ESP";
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                  "noatime"
                  "discard"
                ];
              };
            };
            luks = {
              label = "NIXCRYPT";
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "NIXROOT"
                    "-f"
                  ];
                  subvolumes = {
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "discard"
                      ];
                    };
                    "@persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "discard"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
