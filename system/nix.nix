{
  ...
}:
{
  nix = {
    # gc kills ssds
    gc.automatic = false;

    settings = {
      extra-experimental-features = ["flakes" "nix-command"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5";
    };
  };
}
