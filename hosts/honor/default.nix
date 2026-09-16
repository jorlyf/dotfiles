{
  config,
  flake,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/hardware/cpu/intel-npu.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    (flake.outPath + "/modules/desktop/niri")
    (flake.outPath + "/modules/desktop/programs")
    (flake.outPath + "/modules/desktop/services")
    (flake.outPath + "/modules/gaming")
    (flake.outPath + "/modules/homix.nix")
    (flake.outPath + "/modules/zapret.nix")
    (flake.outPath + "/system")
    ./syncthing.nix
  ];

  niri-config-append-lines = ''
    output "Tianma Microelectronics Ltd. TL160MDMP01 Unknown" {
      mode "3072x1920"
      variable-refresh-rate
    }
  '';

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        energy_performance_preference = "power";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        energy_performance_preference = "balance_performance";
      };
    };
  };

  # нужно для работы камеры, надо подумать, как от этого избавиться
  users.groups.mvusb_dev = { };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="f622", MODE="666", GROUP="mvusb_dev"
    KERNEL=="*", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ACTION=="add", ATTR{idVendor}=="f622", MODE="666", TAG+="mvusb_dev"
    KERNEL=="*", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ACTION=="add", ATTR{idVendor}=="080b", MODE="666", TAG+="mvusb_dev"
    KERNEL=="*", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ACTION=="remove", TAG-="mvusb_dev"
  '';

  environment.systemPackages = [
    pkgs.devenv
    pkgs.exiftool
    pkgs.fastfetch
    pkgs.gnused
    pkgs.keepassxc
    pkgs.nil
    pkgs.nixd
    pkgs.onlyoffice-desktopeditors
    pkgs.podman-compose
    pkgs.podman-tui
    pkgs.qbittorrent
    pkgs.usbutils
    pkgs.xdg-desktop-portal-termfilechooser
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vpl-gpu-rt
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.npu.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
