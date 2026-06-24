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
          "mode": "dark",
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
          "mode": "dark",
          "light": "One Light",
          "dark": "VSCode Dark Polished"
        }
      }
      EOF

      chown -R ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.config/zed
      chmod 644 ${config.users.users.jorlyf.home}/.config/zed/settings.json
    '';
  };
}
