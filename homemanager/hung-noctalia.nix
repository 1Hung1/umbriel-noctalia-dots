{ inputs, pkgs, ... }:

{
  # Import Noctalia home-manager plugin
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # Noctalia settings
  programs.noctalia = {
    enable = true;

    settings = {
      bar = {
        default = {
          start = [
            "launcher"
            "active_window"
            "workspaces"
            "wallpaper"
          ];
          center = [ ];
          end = [
            "tray"
            "notifications"
            "network"
            "volume"
            "battery"
            "control-center"
            "session"
          ];
          margin_edge = 6;
          margin_ends = 18;
          capsule = true;
          background_opacity = 0.8;
          padding = 12;
          radius = 24;
          position = "bottom";
          thickness = 38;
        };
      };
      shell = {
        font_family = "JetBrainsMono Nerd Font Mono";
        telemetry_enabled = true;
        polkit_agent = true;
        password_style = "random";
        show_close_buttons = false;
        launcher = {
          default_view = "all";
          show_app_actions = true;
        };
        panel = {
          transparency_mode = "glass";
        };
        umbriel_audio_provider_enabled = true;
      };
      theme = {
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "vibrant";
        templates = {
          builtin_ids = [
            "alacritty"
            "gtk3"
            "gtk4"
            "qt"
            "umbriel"
          ];
          community_ids = [
            "discord"
            "micro"
            "fastfetch"
          ];
        };
      };
      wallpaper = {
        directory = "~/Pictures/Wallpapers";
        transition_on_startup = true;
        default.path = "~/Pictures/Wallpapers/forest.png";
      };
    };
  };
}
