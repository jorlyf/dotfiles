{
  ...
}:
{
  fileSystems."/persistent".neededForBoot = true;

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/backlight"
      "/var/log"
      "/var/tmp"
    ];

    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];

    users.jorlyf = {
      directories = [
        ".ssh"
        ".cache"
        ".config/discord"
        ".config/fish"
        ".config/kdeconnect"
        ".config/keepassxc"
        ".config/mozilla/firefox"
        ".config/obs-studio"
        ".config/onlyoffice"
        ".local/share/containers"
        ".local/share/devenv"
        ".local/share/direnv"
        ".local/share/fish"
        ".local/share/kdeconnect"
        ".local/share/onlyoffice"
        ".local/share/PrismLauncher"
        ".local/share/Steam"
        ".local/share/TelegramDesktop"
        ".local/share/zed"
        ".local/state/pipewire"
        ".local/state/wireplumber"
        "persistent"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];

      files = [
        ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json"
      ];
    };
  };
}
