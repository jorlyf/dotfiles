{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./ashell
    ./fuzzel
    ./mako
  ];

  options = {
    niri-config-append-lines = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Строки, которые будут добавлены в начало config.kdl";
    };
  };

  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "jorlyf";
        };
      };
    };
    environment.sessionVariables.NIRI_CONFIG = "/etc/niri/config.kdl";
    environment.etc."niri/config.kdl".text = ''
      ${config.niri-config-append-lines}

      ${builtins.readFile ./config.kdl}
    '';

    environment.systemPackages = [
      pkgs.brightnessctl
      pkgs.catppuccin-cursors.frappeLavender
      pkgs.cliphist
      pkgs.libnotify
      pkgs.playerctl
      pkgs.swayidle
      pkgs.swaylock
      pkgs.wl-clipboard
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xwayland-satellite
    ];

    programs.firefox = {
      enable = true;
      preferences = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "media.av1.enabled" = true;
      };
    };
    environment.sessionVariables = {
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };

    catppuccin = {
      autoEnable = true;
      enable = true;
      flavor = "frappe";
      accent = "lavender";
    };

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
        config = {
          common = {
            "default" = [ "gtk" ];
          };
        };
      };
      mime = {
        enable = true;
      };
    };

    environment.sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };
  };
}
