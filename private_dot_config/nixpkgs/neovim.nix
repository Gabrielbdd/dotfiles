{ pkgs, lib, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  programs.neovim = {
    enable = true;
    extraConfig = ''
      source $HOME/.config/nvim/base.vim
    '';
    plugins = with pkgs.vimPlugins; [
      (plugin "sheerun/vim-polyglot")
      (plugin "editorconfig/editorconfig-vim")
      (plugin "dracula/vim")
    ];
  };
}
