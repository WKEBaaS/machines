{ impurity, ... }:
{
  xdg.configFile =
    let
      link = impurity.link;
    in
    {
      "ideavim".source = link ./ideavim;
      "nvim".source = link ./nvim;
      "nvim-vscode".source = link ./nvim-vscode;
      "ghostty".source = link ./ghostty;
      "zed/keymap.json".source = link ./zed/keymap.json;
      "zed/settings.json".source = link ./zed/settings.json;
      "zellij".source = link ./zellij;
    };
}
