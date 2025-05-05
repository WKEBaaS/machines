{ pkgs, ... }:
{
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # utils
    age # A simple, modern and secure encryption tool
    sops
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    just # A handy way to save and run project-specific commands
    bat # A cat(1) clone with wings
    axel # A light download accelerator
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    unar # A program to extract, list, test and view the contents of archives
    unzip # A utility for unpacking zip files
    ripgrep
    # JSON utils
    jq # A lightweight and flexible command-line JSON processor
    jless
    openssl
    mkcert
    openldap

    # misc
    onefetch # Git repository summary generator
    tokei # A program that displays statistics about your code

    # productivity
    dotenv-cli
    direnv
    lazygit

    # lsp related
    nixfmt-rfc-style # Nix formatter
    nil
    # kdlfmt
    # helm-ls
    # hadolint # Dockerfile linter

    # languages
    nodejs_22
    deno
    # go
    # go-migrate
    # pnpm
    # python312
    # rust-bin.stable.latest.default
    # rust-analyzer
  ];

  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    # terminal file manager
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableZshIntegration = true;
    };

    zellij = {
      enable = true;
    };
  };
}
