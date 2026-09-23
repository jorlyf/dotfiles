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

  environment.systemPackages = [
    pkgs.devenv
    pkgs.fastfetch
    pkgs.kdePackages.dolphin
    pkgs.keepassxc
    pkgs.nil
    pkgs.nixd
    pkgs.onlyoffice-desktopeditors
    pkgs.podman-compose
    pkgs.podman-tui
    pkgs.qbittorrent
    pkgs.usbutils
  ];

  system.stateVersion = "26.05";
}
