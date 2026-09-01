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
  ];

  boot.loader.limine = {
    extraEntries = ''
      /Windows
      protocol: efi
      path: uuid(c593e69a-ddd6-4457-8d41-46fd3a72b1db):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  niri-config-append-lines = ''
    output "ViewSonic Corporation VX24G26J-4K YPU262800439" {
      mode "3840x2160"
      focus-at-startup
      position x=0 y=0
    }

    output "PNP(SAC) G5c II 0000000000000" {
      mode "2560x1440"
      scale 1.15
      position x=2194 y=0
    }
  '';

  games = {
    minecraft.enable = true;
  };

  programs.obs-studio = {
    package = pkgs.obs-studio.override {
      cudaSupport = true;
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

  environment.systemPackages = with pkgs; [
    devenv
    exiftool
    fastfetch
    gnused
    keepassxc
    nil
    nixd
    onlyoffice-desktopeditors
    podman-compose
    podman-tui
    qbittorrent
    usbutils
    xdg-desktop-portal-termfilechooser
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
