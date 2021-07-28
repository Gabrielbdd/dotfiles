{ config, pkgs, lib, ... }:
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

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    FZF_DEFAULT_COMMAND = "fd --type f";
    DISPLAY = "$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0";
    GPG_TTY = "$(tty)";
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

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
    pkgs.up
    pkgs.xclip
    pkgs.rink
    pkgs.yadm

    ## oci
    pkgs.podman
    pkgs.podman-compose
    pkgs.buildah
    pkgs.kubectl

    ## cloud
    #pkgs.azure-cli
    pkgs.awscli2

    ## security
    pkgs.rage
    pkgs.sops

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
    git = {
      enable = true;
      userName = "Gabriel Berto";
      userEmail = "gabriel.berto@pottencial.com.br";
      delta = {
        enable = true;
        options = {
          syntax-theme = "Dracula";
        };
      };
      extraConfig = {
        init.defaultBranch = "main";
        push.default = "current";
        rebase.autostash = "true";
        pull.rebase = "true";
      };
    };

    fish = {
      enable = true;
      loginShellInit = "source ~/.config/fish/user_config.fish";
      shellAliases = {
        ls = "lsd";
        hm = "home-manager";
        za = "zoxide add";
        zr = "zoxide remove";
      };
      plugins = [
        {
          name = "fisher";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "fisher";
            rev = "b9b1eda07a9325e7641f3f79f9c7a08d8de3b357";
            sha256 = "033b2zr804iblcqj5pl88qng1dx7cw05f1lhzx5d72b0jfrcyl2z";
          };
        }
      ];
    };

    starship = {
      enable = true;
      settings = {
        git_status.disabled = true;
      };
    };

    neovim = {
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

    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
