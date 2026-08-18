{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.alacritty
  ];

  homix = {
    ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };
}
