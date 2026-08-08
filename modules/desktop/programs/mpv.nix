{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mpv
  ];

  homix = {
    ".config/mpv/mpv.conf".text = ''
      hwdec=auto
    '';
  };
}
