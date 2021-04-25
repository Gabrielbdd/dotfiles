#!/bin/sh

# install homebrew if it's missing
if ! command -v brew >/dev/null 2>&1; then
	echo "Installing homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -f "$HOME/.Brewfile" ]; then
	echo "Updating homebrew bundle"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew bundle --global
fi

