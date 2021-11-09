{ pkgs, ... }:

let imports = [
  ./git.nix
  ./fish.nix
  ./tmux.nix
  ./neovim.nix
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
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      FZF_DEFAULT_COMMAND = "fd --type f";
      DISPLAY = "$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0";
      GPG_TTY = "$(tty)";
    };
  };

  home.packages = with pkgs; [
    # utils
    ncurses
    /* git */
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
    xclip
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

    ## oci
    # podman
    # podman-compose
    # buildah
    # kubectl

    ## cloud
    azure-cli
    awscli2

    ## security
    rage # Rust implementation of age, a simple a secure encryption tool
    # sops # Created by Mozilla, its an editor of encrypted files
    diceware # Passphrase generator

    # shell
    nushell
    fish
    powershell

    ## prompt
    starship

    # editor
    neovim-nightly

    # languages
    ## java script
    nodejs
    yarn
    nodePackages.pnpm
    ## rust
    rustup
    ## ruby
    ruby
  ];
}
