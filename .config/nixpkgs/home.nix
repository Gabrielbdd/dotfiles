{ pkgs, ... }:

let
  imports = [
    ./git.nix
    ./fish.nix
    ./neovim.nix
    ./starship.nix
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
    # pkgs.up
    pkgs.xclip
    # pkgs.rink
    pkgs.yadm

    ## oci
    # pkgs.podman
    # pkgs.podman-compose
    # pkgs.buildah
    # pkgs.kubectl

    ## cloud
    #pkgs.azure-cli
    pkgs.awscli2

    ## security
    # pkgs.rage
    # pkgs.sops

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
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
