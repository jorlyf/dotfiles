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
  };
}
