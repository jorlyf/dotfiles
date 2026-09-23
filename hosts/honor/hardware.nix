{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  hardware = {
    cpu.intel = {
      npu.enable = true;
      updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    graphics = {
      enable = true;
      extraPackages = [
        pkgs.intel-media-driver
        pkgs.vpl-gpu-rt
      ];
    };
  };

  services.xserver.videoDrivers = [ "modesetting" ];
}
