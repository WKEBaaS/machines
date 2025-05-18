{
  lib,
  isDarwin,
  ...
}:
{
  programs.zsh = {
    enable = true;

    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        zstyle ':completion:*' matcher-list '''''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        function zvm_config() {
          ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
          ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
          ZVM_KEYTIMEOUT=0.03
        }

        function zvm_after_init() {
          eval "$(fzf --zsh)"
        }
      '')
      (lib.mkOrder 1200 ''
        export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"
        export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
        # Currently, zellij does not follow symlink configs update
        export ZELLIJ_CONFIG_DIR=${builtins.getEnv "IMPURITY_PATH" + "/homes/youmin/dotfiles/zellij"}
      '')
    ];

    autocd = true;

    enableCompletion = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    antidote = {
      enable = true;
      plugins = [
        "Aloxaf/fzf-tab"
        "jeffreytse/zsh-vi-mode"
        "paulirish/git-open"
      ];
    };
  };

  home.shellAliases = {
    k = "kubectl";
    cz = "chezmoi";
    lg = "lazygit";
    rm = lib.mkIf (isDarwin) "trash";
    ii = lib.mkIf (isDarwin) "open -a Finder.app";
    zed = lib.mkIf (!isDarwin) "zeditor";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}
