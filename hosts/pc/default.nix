{
  flake,
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
    (flake.outPath + "/modules/mvsdk.nix")
    (flake.outPath + "/modules/zapret.nix")
    (flake.outPath + "/system")
    ./disko.nix
    ./hardware.nix
    ./syncthing.nix
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

  environment.systemPackages = [
    pkgs.devenv
    pkgs.exiftool
    pkgs.fastfetch
    pkgs.gnused
    pkgs.kdePackages.dolphin
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

  system.stateVersion = "26.11";
}
