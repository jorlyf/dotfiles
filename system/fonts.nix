{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      corefonts
      fira-code
      fira-code-symbols
      font-awesome
      liberation_ttf
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      vista-fonts
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
