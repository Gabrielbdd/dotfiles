{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = [
    # utils
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
    pkgs.up
    pkgs.xclip
    pkgs.rink
    pkgs.yadm

    ## oci
    pkgs.podman
    pkgs.podman-compose
    pkgs.buildah

    ## cloud
    pkgs.azure-cli
    pkgs.awscli2

    ## db
    pkgs.pgcli

    ## security
    pkgs.rage
    pkgs.sops

    # shell
    pkgs.nushell
    pkgs.fish

    ## prompt
    pkgs.starship

    # editor
    pkgs.neovim

    # languages
    ## node
    pkgs.yarn
    pkgs.nodePackages.npm
    pkgs.nodePackages.pnpm
  ];
}
