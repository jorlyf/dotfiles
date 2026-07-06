{
  config,
  ...
}:
{
  system.activationScripts.createZedConfigDirect = {
    text = ''
      mkdir -p ${config.users.users.jorlyf.home}/.config/zed

      cat > ${config.users.users.jorlyf.home}/.config/zed/settings.json << EOF
      {
        "disable_ai": true,
        "auto_install_extensions": {
          "catppuccin": true,
          "catppuccin-icons": true,
          "html": true,
          "scss": true,
          "neocmake": true,
        },
        "theme": {
          "mode": "dark",
          "light": "Catppuccin Latte",
          "dark": "Catppuccin Frappé",
        },
        "icon_theme": {
          "mode": "dark",
          "light": "Catppuccin Latte",
          "dark": "Catppuccin Frappé",
        },
        "ui_font_family": ".SystemUIFont",
        "ui_font_size": 16.0,
        "buffer_font_family": ".ZedMono",
        "buffer_font_size": 16.0,
        "soft_wrap": "bounded",
        "preferred_line_length": 120,
        "base_keymap": "VSCode",
        "use_podman": true,
        "tab_size": 2,
        "minimap": {
          "show": "never",
        },
        "project_panel": {
          "dock": "left",
          "default_width": 450.0,
        },
        "outline_panel": {
          "dock": "right",
        },
        "git_panel": {
          "dock": "left",
          "default_width": 450.0,
          "tree_view": false,
          "status_style": "icon",
        },
        "diagnostics": {
          "inline": {
            "enabled": true,
            "max_severity": null,
          },
        },
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
            "function": false,
          },
        },
        "telemetry": {
          "diagnostics": false,
          "metrics": false,
        },
      }
      EOF

      chown -R ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.config/zed
      chmod 644 ${config.users.users.jorlyf.home}/.config/zed/settings.json
    '';
  };
}
