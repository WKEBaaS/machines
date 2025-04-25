{ ... }:
{
  programs.kitty = {
    enable = false;
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "DejaVuSansM Nerd Font Mono";
      size = 16;
    };

    settings = {
      enabled_layouts = "splits";
      tab_bar_style = "slant";
      background_opacity = "0.9";
      hide_window_decorations = "yes";
      initial_window_width = "125c";
      initial_window_height = "40c";
      macos_option_as_alt = "left";
      kitty_mod = "ctrl+shift";
    };

    themeFile = "Dracula";

    keybindings = {
      "f4" = "launch --location=split";
      "f5" = "launch --location=vsplit";
      "f6" = "launch --location=hsplit";

      # Switch focus to the neighboring window in the indicated direction
      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+l" = "neighboring_window right";
      "kitty_mod+k" = "neighboring_window up";
      "kitty_mod+j" = "neighboring_window down";

      # Move the active window to the indicated screen edge
      "kitty_mod+up" = "layout_action move_to_screen_edge top";
      "kitty_mod+left" = "layout_action move_to_screen_edge left";
      "kitty_mod+right" = "layout_action move_to_screen_edge right";
      "kitty_mod+down" = "layout_action move_to_screen_edge bottom";
    };
  };
}
