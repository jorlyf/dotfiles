{
  inputs,
  ...
}:
{
  environment.systemPackages = [
    inputs.amane.packages.x86_64-linux.default
  ];

  services.upower = {
    enable = true;
  };

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".local/state/amane"
      ];
    };
  };
}
