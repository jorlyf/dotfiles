{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ {nixpkgs, impermanence, ...}: let

  in {
    nixosConfigurations = import ./hosts inputs;
  };
}
