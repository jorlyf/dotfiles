{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  environment.systemPackages = [
    pkgs.catppuccin-cursors.frappeLavender
  ];

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "frappe";
    accent = "lavender";
  };

  # niri-config-append-lines = ''
  #   cursor {
  #     xcursor-theme "catppuccin-frappe-lavender-cursors"
  #   }
  # '';
}
