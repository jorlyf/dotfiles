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
    (flake.outPath + "/modules/homix.nix")
    (flake.outPath + "/system/services/openssh.nix")
    (flake.outPath + "/system/services/syncthing.nix")
    (flake.outPath + "/system/services/upower.nix")
    (flake.outPath + "/system/bluetooth.nix")
    (flake.outPath + "/system/boot.nix")
    (flake.outPath + "/system/common.nix")
    (flake.outPath + "/system/disks.nix")
    (flake.outPath + "/system/fonts.nix")
    (flake.outPath + "/system/networking.nix")
    (flake.outPath + "/system/nix.nix")
    (flake.outPath + "/system/podman.nix")
    (flake.outPath + "/system/security.nix")
    (flake.outPath + "/system/users.nix")
    (flake.outPath + "/user/de/default.nix")
    (flake.outPath + "/user/yazi/default.nix")
    (flake.outPath + "/user/zed/default.nix")
    (flake.outPath + "/user/firefox.nix")
    (flake.outPath + "/user/fish.nix")
    (flake.outPath + "/user/git.nix")
    (flake.outPath + "/user/gtk.nix")
    (flake.outPath + "/user/obs-studio.nix")
    (flake.outPath + "/user/steam.nix")
    (flake.outPath + "/user/xdg.nix")
  ];

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "powersave";
        turbo = "never";
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

  environment.systemPackages = with pkgs; [
    brightnessctl
    chromium
    cliphist
    devenv
    exiftool
    fastfetch
    fuzzel
    ghostty
    gnused
    keepassxc
    mako
    mpv
    nil
    nixd
    onlyoffice-desktopeditors
    podman-compose
    podman-tui
    swayidle
    swaylock
    telegram-desktop
    usbutils
    wl-clipboard
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-termfilechooser
    xwayland-satellite
    zed-editor
  ];

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
