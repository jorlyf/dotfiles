{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.mpv
  ];

  homix = {
    ".config/mpv/mpv.conf".text = ''
      hwdec=auto
    '';
  };
}
