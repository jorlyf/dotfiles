{
  inputs,
  pkgs,
  ...
}:
let
  # https://github.com/Diegiwg/PrismLauncher-Cracked/issues/36
  prismlauncher-cracked-fixed =
    inputs.prismlauncher-cracked.packages.${pkgs.stdenv.hostPlatform.system}.default.override
      {
        prismlauncher-unwrapped =
          (
            inputs.prismlauncher-cracked.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher-unwrapped.override
            {
              extra-cmake-modules = pkgs.kdePackages.extra-cmake-modules;
            }
          ).overrideAttrs
            (oldAttrs: {
              nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
                pkgs.pkg-config
              ];
            });
      };
in
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };

  environment.systemPackages = [
    pkgs.discord
    pkgs.gamemode
    pkgs.mangohud
    pkgs.jdk25
    prismlauncher-cracked-fixed
  ];
}
