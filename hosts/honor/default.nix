{
  inputs,
  lib,
  config,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/hardware/cpu/intel-npu.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.impermanence.nixosModules.impermanence
  ];

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

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      corefonts
      vista-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      font-awesome
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      nerd-fonts.iosevka
    ];
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5";
    };
  };

  programs.niri.enable = true;
  # spawn-sh-at-startup "kdeconnect-indicator"

  programs.nm-applet.enable = true;

  environment.etc."niri/config.kdl".text = ''
    spawn-sh-at-startup "wl-paste --watch cliphist store"

    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:alt_shift_toggle"
            }

            repeat-delay 200
            repeat-rate 25
        }

        touchpad {
            tap
            natural-scroll
            accel-profile "flat"
        }

        mouse {
            accel-profile "flat"
        }
    }

    layout {
        gaps 16

        center-focused-column "never"

        background-color "transparent"

        preset-column-widths {
            proportion 0.5
            proportion 0.75
            proportion 1.0
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 1
            active-color "#c6d0f5"
            urgent-color "#ff0000"
        }

        border {
            off
        }

        shadow {
            off
        }
    }

    window-rule {
        geometry-corner-radius 4
        clip-to-geometry true
        tiled-state true
    }

    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path null

    overview {
        backdrop-color "#222222"
    }

    animations {
        slowdown 0.8
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+E hotkey-overlay-title="Open a file manager: dolphin" { spawn "dolphin"; }
        Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }
        Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }
        Mod+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

        XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }

        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

        Mod+O repeat=false { toggle-overview; }

        Mod+Q repeat=false { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+C { center-column; }

        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+M       { toggle-window-floating; }
        Mod+Shift+M { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Mod+F12 { screenshot; }
        Mod+Ctrl+Print { screenshot-screen; }
        Mod+Alt+Print { screenshot-window; }

        Mod+V { spawn-sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
    }
  '';

  environment.sessionVariables.NIRI_CONFIG = "/etc/niri/config.kdl";

  environment.etc."xdg/waybar/config.jsonc".text = ''
    // -*- mode: jsonc -*-
    {
      "margin-top": 4,
      "spacing": 4,
      "modules-left": ["niri/workspaces", "niri/window"],
      "modules-center": ["clock"],
      "modules-right": [
        "tray",
        "network",
        "niri/language",
        "privacy",
        "wireplumber",
        "backlight",
        "memory",
        "battery",
        "power-profiles-daemon",
        "custom/power",
      ],
      "niri/workspaces": {},
      "niri/window": {
        "format": "{title}",
        "icon": true,
      },
      "clock": {
        "interval": 1,
        "format": "{:%H:%M:%S %d.%m.%Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
      },
      "tray": {
        "spacing": 12,
      },
      "network": {
        "interval": 5,
        "format": "{ifname}",
        "format-wifi": "{signalStrength}% ",
        "tooltip-format": "{essid} | {ifname} | {ipaddr}",
      },
      "bluetooth": {
        "format": " {status}",
        "format-disabled": "",
        "format-connected": " {num_connections} connected",
        "tooltip-format": "{controller_alias}\t{controller_address}",
        "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
      },
      "niri/language": {
        "format": "{short} {variant}",
      },
      "privacy": {
        "icon-spacing": 4,
        "icon-size": 15,
        "transition-duration": 250,
        "modules": [
          {
            "type": "screenshare",
            "tooltip": true,
            "tooltip-icon-size": 24,
          },
          {
            "type": "audio-out",
            "tooltip": true,
            "tooltip-icon-size": 24,
          },
          {
            "type": "audio-in",
            "tooltip": true,
            "tooltip-icon-size": 24,
          },
        ],
      },
      "wireplumber": {
        "format": "{volume}% {icon}  {format_source}",
        "format-bluetooth": "{volume}%  {format_source}",
        "format-bluetooth-muted": " {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
          "default": ["󰕿", "󰖀", "󰕾"],
        },
        "tooltip": false,
        "on-click": "pavucontrol",
      },
      "backlight": {
        "format": "{percent}% {icon}",
        "format-icons": ["", "", "", "", "", "", "", "", ""],
        "tooltip": false,
      },
      "cpu": {
        "format": "{usage}% ",
        "tooltip": false,
      },
      "memory": {
        "interval": 5,
        "format": "{used} GiB ",
        "tooltip": false,
      },
      "battery": {
        "interval": 5,
        "full-at": 99,
        "states": {
          "warning": 30,
          "critical": 10,
        },
        "format": "{capacity}% {icon} {time}",
        "format-time": "{H}:{m}",
        "format-charging": "{capacity}% 󰂄",
        "format-plugged": "{capacity}% ",
        "format-icons": ["", "", "", "", ""],
        "tooltip": false,
      },
      "power-profiles-daemon": {
        "format": "{icon}",
        "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
        "tooltip": true,
        "format-icons": {
          "default": "",
          "performance": "",
          "balanced": "",
          "power-saver": "",
        },
      },
      "custom/power": {
        "format": "⏻",
        "menu": "on-click",
        "menu-file": "$HOME/.config/waybar/power_menu.xml",
        "menu-actions": {
          "shutdown": "shutdown",
          "reboot": "reboot",
          "suspend": "systemctl suspend",
        },
        "tooltip": false,
      },
    }
  '';

  environment.etc."xdg/waybar/style.css".text = ''
    * {
      font-family: Iosevka, FontAwesome, Noto Sans CJK, Roboto, sans-serif;
      font-size: 15px;
    }

    #waybar {
      background: transparent;
      /*background-color: @theme_base_color;*/
      color: #c6d0f5;
      /*color: @theme_text_color;*/
    }

    #waybar.hidden {
      opacity: 0.2;
    }

    #window {
      padding-left: 24px;
    }

    button {
      box-shadow: inset 0 -3px transparent;
      border: none;
      border-radius: 0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    button:hover {
      background: inherit;
      box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button {
      padding: 0 5px;
      color: #c6d0f5;
    }

    #workspaces button.active {
      color: #99d1db;
    }

    #workspaces button.focused {
      background-color: #64727d;
      box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
      background-color: #eb4d4b;
    }

    #clock,
    #tray,
    #network,
    #bluetooth,
    #language,
    #privacy,
    #wireplumber,
    #backlight,
    #cpu,
    #memory,
    #battery,
    #power-profiles-daemon {
      background-color: #1a1b26;
      padding: 4px 8px;
      border-radius: 8px;
    }

    #custom-power {
      padding: 4px 8px;
      margin-right: 4px;
      border-radius: 8px;
      font-size: 20px;
    }

    #custom-media {
      color: #2a5c45;
      min-width: 100px;
    }

    /*#custom-media.custom-spotify {
    }

    #custom-media.custom-vlc {
    }*/

    #tray menu {
      background-color: #1a1b26;
      color: #c6d0f5;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #eb4d4b;
    }
  '';

  system.activationScripts.createZedConfigDirect = {
    text = ''
      mkdir -p ${config.users.users.jorlyf.home}/.config/zed

      cat > ${config.users.users.jorlyf.home}/.config/zed/settings.json << EOF
      {
        "auto_install_extensions": {
          "vscode-dark-polished": true,
          "material-icon-theme": true,
          "html": true,
          "scss": true,
          "neocmake": true
        },
        "agent_servers": {},
        "cli_default_open_behavior": "existing_window",
        "use_podman": true,
        "collaboration_panel": {
          "dock": "left"
        },
        "edit_predictions": {
          "provider": "zed"
        },
        "outline_panel": {
          "dock": "right"
        },
        "preferred_line_length": 120,
        "soft_wrap": "bounded",
        "agent": {
          "flexible": true,
          "default_profile": "ask",
          "sidebar_side": "right",
          "dock": "right",
          "default_model": {
            "enable_thinking": false,
            "provider": "lmstudio",
            "model": "qwen/qwen3.5-9b"
          },
          "favorite_models": [],
          "model_parameters": []
        },
        "project_panel": {
          "dock": "left",
          "default_width": 450.0
        },
        "scroll_sensitivity": 1.0,
        "vertical_scroll_margin": 3.0,
        "centered_layout": {
          "right_padding": 0.2,
          "left_padding": 0.2
        },
        "diagnostics": {
          "inline": {
            "enabled": true,
            "max_severity": null
          }
        },
        "bottom_dock_layout": "contained",
        "title_bar": {
          "show_branch_status_icon": true,
          "show_menus": true
        },
        "git_panel": {
          "dock": "left",
          "tree_view": false,
          "status_style": "icon"
        },
        "tabs": {
          "file_icons": false,
          "git_status": false
        },
        "autosave": "off",
        "agent_ui_font_size": 16.0,
        "buffer_font_family": ".ZedMono",
        "confirm_quit": true,
        "buffer_font_weight": 400.0,
        "auto_update": false,
        "inlay_hints": {
          "enabled": true,
          "show_value_hints": true,
          "show_type_hints": true,
          "show_parameter_hints": true,
          "show_other_hints": true,
          "show_background": false,
          "edit_debounce_ms": 700,
          "scroll_debounce_ms": 50,
          "toggle_on_modifiers_press": {
            "control": false,
            "alt": false,
            "shift": false,
            "platform": false,
            "function": false
          }
        },
        "ui_font_family": ".SystemUIFont",
        "minimap": {
          "show": "auto"
        },
        "tab_size": 2,
        "icon_theme": {
          "mode": "system",
          "light": "Zed (Default)",
          "dark": "Material Icon Theme"
        },
        "telemetry": {
          "diagnostics": false,
          "metrics": false
        },
        "base_keymap": "VSCode",
        "ui_font_size": 16.0,
        "buffer_font_size": 16.0,
        "theme": {
          "mode": "system",
          "light": "One Light",
          "dark": "VSCode Dark Polished"
        }
      }
      EOF

      chown -R ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.config/zed
      chmod 644 ${config.users.users.jorlyf.home}/.config/zed/settings.json
    '';
  };

  programs.git = {
    enable = true;
  };

  system.activationScripts.createUserGitconfig = {
    text = ''
      touch ${config.users.users.jorlyf.home}/.gitconfig

      cat > ${config.users.users.jorlyf.home}/.gitconfig << EOF
      [user]
        name = jorlyf
        email = jorlyfchannel@gmail.com
      [core]
        editor = nano
      EOF

      chown ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.gitconfig
      chmod 644 ${config.users.users.jorlyf.home}/.gitconfig
    '';
  };

  programs.firefox = {
    enable = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.steam = {
    enable = true;
  };

  programs.waybar.enable = true;
  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    fuzzel
    swaylock
    mako
    swayidle
    xwayland-satellite
    onlyoffice-desktopeditors
    xdg-desktop-portal-gnome
    kdePackages.filelight
    kdePackages.kate
    telegram-desktop
    zed-editor
    obs-studio
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "jorlyf";
      };
    };
  };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "powersave";
      turbo = "never";
    };
  };

  boot.loader.limine = {
    enable = true;
  };

  boot.loader.systemd-boot.enable = false;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-label/NIXCRYPT";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems = {
    "/boot" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["noatime" "discard"];
    };

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["size=2G" "mode=755"];
    };

    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["noatime" "discard" "subvol=@nix" "compress=zstd"];
    };

    "/persistent" = {
      neededForBoot = true;
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = ["noatime" "discard" "subvol=@persistent" "compress=zstd"];
    };
  };

  zramSwap.enable = true;

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  users = {
    mutableUsers = false;

    users = {
      root = {
        initialPassword = "admin";
      };

      jorlyf = {
        isNormalUser = true;
        uid = 1000;
        initialPassword = "admin";

        shell = pkgs.fish;

        extraGroups = [
          "wheel"
          "systemd-journal"
          # "vboxusers"
          # "audio"
          # "plugdev"
          # "wireshark"
          # "video"
          # "input"
          # "lp"
          "networkmanager"
          "podman"
          # "power"
          # "nix"
          # "adbusers"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/yHjLgWq1zka2rtpkHos/I4Yv19USnkh512PniZM6upW3BMNyrQuTiK8YUQWcBXKjBjlZfGdp64gJnv9MTFiBMp+cHGLVZktr5kl94GqCwkPlckvrhSlcFsgk8SMyHA9dyNki7uU0v5HrD9T4FQJTSXkwPSBQrczQdzUAnOEP/Q73KEzwUinKVXgH62GRd0o5mdRdXOXnxpErPbGTAy2zNP6zl0mb+FliSNy9lFtR5mxE9i5x8ro7DVl+l+5ylX9CyA3M/gQYJh/sT/7Umw65j3dWzwyapMHWV5ALO+o5cgzgwR9nJ/Pf+uhhvUcUSE2DAgYGq2xNb6o4epekQhmupcJPoygz8PY7gzOGf/RHlRx9Ha8hsGy+3cBzk34K5FsnIzLu+Z7v2YgZNj3u0m+L706k1vdUV2ToCJ5zKlZSGrDUg8SfS0td9WH/9M+plsJthirehDgs6FUWeVOUq//d7N+WHdAqnArGzn3ZifOSsb6j89SK3LxWV1I/s/3y7Ac= jorlyf@jorlyf"
        ];
      };
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  systemd.user.services.corefonts-to-home = {
    description = "Link fonts to user directory on login";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/mkdir -p %h/.local/share/fonts && ${pkgs.coreutils}/bin/ln -sfT ${pkgs.corefonts}/share/fonts/truetype %h/.local/share/fonts/corefonts'";
    }; # chown -h
  };

  time.timeZone = "Europe/Samara";
  system.stateVersion = "26.05";

  environment.etc.machine-id.text = "15e857fea7a440f9b8d7bc7b0c4a584b";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/backlight"
    ];

    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];

    users.jorlyf = {
      directories = [
        ".ssh"
        ".config/mozilla/firefox"
        ".config/fish"
        ".config/onlyoffice"
        ".config/obs-studio"
        ".local/share/containers"
        ".local/share/keyrings"
        ".local/share/fish"
        ".local/share/onlyoffice"
        ".local/share/TelegramDesktop"
        ".local/share/zed"
        ".local/state/wireplumber"
        ".local/state/pipewire"
        "persistent"
        "Documents" "Downloads" "Pictures" "Videos"
      ];
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.npu.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
