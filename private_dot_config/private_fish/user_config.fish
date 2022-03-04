# hide greeting message
set fish_greeting

fish_add_path -m /usr/local/bin

# Vi mode
fish_vi_key_bindings
set fish_cursor_replace_one underscore

set -gx PNPM_HOME "/home/gabriel/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

alias lg lazygit

# See why it makes the start freeze
podman completion fish | source

