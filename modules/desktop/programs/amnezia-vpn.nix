{
  ...
}:
{
  programs.amnezia-vpn.enable = true;

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".config/AmneziaVPN.ORG"
      ];
    };
  };
}
