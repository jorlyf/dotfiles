{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.tinymist
    pkgs.typst
  ];
}
