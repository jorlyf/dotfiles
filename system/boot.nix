{
  ...
}:
{
  boot = {
    loader = {
      limine = {
        enable = true;
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-label/NIXCRYPT";
      preLVM = true;
      allowDiscards = true;
    };
  };
}
