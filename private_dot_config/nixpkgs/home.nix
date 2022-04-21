{ pkgs, ... }:

let
  imports = [
    ./git.nix
    ./fish.nix
    ./tmux.nix
    # ./neovim.nix
    ./starship.nix
    ./zoxide.nix
    ./bat.nix
  ];
in {
  inherit imports;

  programs.home-manager.enable = true;

  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "21.05";
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      FZF_DEFAULT_COMMAND = "fd --type f";
      GPG_TTY = "$(tty)";
      COLORTERM = "truecolor";
    };
  };

  home.packages = with pkgs; [
    # utils
    jdupes # Work on duplicated files
    ncurses
    # git
    git-trim
    lazygit
    lsd
    fzf
    ripgrep
    fd
    sd
    jq
    bat
    zoxide
    tealdeer
    bottom
    delta
    up # The ultimate plumber
    # xclip
    wl-clipboard
    # rink # Unit conversion tool
    yadm
    chezmoi
    yank # Yank terminal to clipboard
    tmux
    cheat # View and create interactive cheatsheets
    dogdns # Dig alternative
    pandoc # Markup files conversion
    ouch # Compress / decompress files
    cachix
    wget
    unzip
    # gcc
    just # commands runner
    # ffmpeg
    sqlite-web
    tesseract

    # server
    # apacheHttpd

    # oci
    podman
    podman-compose
    buildah

    # kubernetes
    kubectl
    k9s
    helm

    # cloud
    azure-cli
    awscli2

    rage # Rust implementation of age, a simple a secure encryption tool
    # sops # Created by Mozilla, its an editor of encrypted files
    diceware # Passphrase generator

    # shell
    # nushell
    fish
    powershell
    oil

    # prompt
    starship

    # editor
    # neovim
    # helix

    # java script
    # yarn
    # nodePackages.pnpm

    # rust
    # rustup
    # rust-analyzer

    # ruby
    ruby

    # lua
    stylua

    # deno
    deno

    # zig
    zig

    # php
    # php81
    # php81Packages.composer

    # lisp
    fennel
    fnlfmt

    # nix
    nixfmt
  ];
}
