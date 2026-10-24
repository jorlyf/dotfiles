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
        ".local/share/devenv"
        ".local/share/direnv"
        ".local/state/pipewire"
        ".local/state/wireplumber"
        "persistent"
      ];
    };
  };
}
