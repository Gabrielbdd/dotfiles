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

  home.packages = [
    # utils
    pkgs.git
    pkgs.git-trim
    pkgs.lsd
    pkgs.fzf
    pkgs.ripgrep
    pkgs.fd
    pkgs.sd
    pkgs.jq
    pkgs.bat
    pkgs.zoxide
    pkgs.tealdeer
    pkgs.bottom
    pkgs.delta
    pkgs.up # The ultimate plumber
    pkgs.xclip
    # pkgs.rink # Unit conversion tool
    pkgs.yadm
    pkgs.chezmoi
    pkgs.yank # Yank terminal to clipboard
    pkgs.tmux
    pkgs.cheat # View and create interactive cheatsheets
    pkgs.dogdns # Dig alternative
    pkgs.pandoc # Markup files conversion

    ## oci
    # pkgs.podman
    # pkgs.podman-compose
    # pkgs.buildah
    # pkgs.kubectl

    ## cloud
    pkgs.azure-cli
    pkgs.awscli2

    ## security
    pkgs.rage # Rust implementation of age, a simple a secure encryption tool
    # pkgs.sops # Created by Mozilla, its an editor of encrypted files
    pkgs.diceware # Passphrase generator

    # shell
    pkgs.nushell
    pkgs.fish
    pkgs.powershell

    ## prompt
    pkgs.starship

    # editor
    pkgs.neovim-nightly

    # languages
    ## node
    pkgs.yarn
    pkgs.nodePackages.pnpm
    ## rust
    pkgs.rustup
  ];
}
