{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  environment = {
    systemPackages = [
      pkgs.podman-compose
      pkgs.podman-tui
    ];
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".local/share/containers"
        ];
      };
    };
  };
}
