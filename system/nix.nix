{
  ...
}:
{
  nix = {
    # gc kills ssds
    gc.automatic = false;

    settings = {
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # WE DONT WANT TO BUILD STUFF ON TMPFS
  # ITS NOT A GOOD IDEA
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };
}
