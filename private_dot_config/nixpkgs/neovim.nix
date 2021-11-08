{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    # (import (builtins.fetchTarball {
    #  url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    # }))
    (self: super: {

      tree-sitter-updated = super.tree-sitter.overrideAttrs(oldAttrs: {
        version = "0.17.3";
        sha256 = "sha256-uQs80r9cPX8Q46irJYv2FfvuppwonSS5HVClFujaP+U=";
        cargoSha256 = "sha256-fonlxLNh9KyEwCj7G5vxa7cM/DlcHNFbQpp0SwVQ3j4=";

        postInstall = ''
          PREFIX=$out make install
        '';
      });

      neovim-nightly = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
        name = "neovim-nightly";
        version = "0.5-nightly";
        src = self.fetchurl {
          url = "https://github.com/neovim/neovim/archive/master.zip";
          sha256 = "1bjvl00s9zggds8f68cmdiq28gp9f1abwjc81n4bym5z6ncd233a";
        };

        nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
      });
     })
  ];

  programs.neovim = {
    enable = true;
  };
}
