{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;

    packages = [
      pkgs.corefonts
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.font-awesome
      pkgs.liberation_ttf
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.symbols-only
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-color-emoji
      pkgs.vista-fonts
    ];
  };

  # Для OnlyOffice (не отображаются установленные в системе шрифты)
  systemd.user.services.corefonts-to-home = {
    description = "Link fonts to user directory on login";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/mkdir -p %h/.local/share/fonts && ${pkgs.coreutils}/bin/cp -r ${pkgs.corefonts}/share/fonts/truetype %h/.local/share/fonts/corefonts'";
    };
  };
}
