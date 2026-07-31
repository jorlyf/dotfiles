{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    catppuccin.url = "github:catppuccin/nix";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs =
    inputs@{
      nixpkgs,
      impermanence,
      catppuccin,
      zapret-discord-youtube,
      ...
    }:
    {
      nixosConfigurations = import ./hosts inputs;
    };
}
