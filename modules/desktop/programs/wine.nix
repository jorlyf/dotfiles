{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.wine
    pkgs.winetricks
    pkgs.wineWow64Packages.waylandFull
  ];
}
