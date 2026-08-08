{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.games.minecraft;

  # https://github.com/Diegiwg/PrismLauncher-Cracked/issues/36
  prismlauncher-cracked-fixed =
    inputs.prismlauncher-cracked.packages.${pkgs.stdenv.hostPlatform.system}.default.override
      {
        jdks = [ pkgs.jdk25 ];

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
  options = {
    games.minecraft.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Установить PrismLauncher";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      prismlauncher-cracked-fixed
    ];
  };
}
