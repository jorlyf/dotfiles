{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.resources
  ];
}
