#!/usr/bin/sh

# install nix if it's missing
if ! command -v brew >/dev/null 2>&1; then
	echo "Installing nix"
  curl -L https://nixos.org/nix/install | sh
  nix-channel --update
fi

# install home-manager if it's missing
if ! command -v home-manager >/dev/null 2>&1; then
	echo "Installing home-manager"
  nix-shell '<home-manager>' -A install
  home-manager switch
fi
