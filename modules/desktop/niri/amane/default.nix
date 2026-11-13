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

  homix = {
    ".local/state/amane/config-path".text = ''
      /home/jorlyf/persistent/amane-cfg
    '';
  };

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".local/state/amane"
      ];
    };
  };
}
