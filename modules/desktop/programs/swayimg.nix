{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.swayimg
  ];
}
