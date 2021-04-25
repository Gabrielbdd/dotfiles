# Useful aliases
alias ls="lsd"
alias codi="code-insiders"
alias hm="home-manager"
alias za="zoxide add"
alias zr="zoxide remove"

fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin

# Use fd as default command for fzf
set -gx FZF_DEFAULT_COMMAND 'fd --type f'
# Set current wsl IP
set -gx IP (grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}')
set -gx DISPLAY (echo $IP):0
set -gx GPG_TTY (tty)
set -gx VISUAL nvim
set -gx EDITOR nvim
# Use bat as man pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# See why it makes the start freeze
#podman completion fish | source

starship init fish | source

zoxide init fish | source

# Fix for: https://github.com/microsoft/WSL/issues/5065
for i in (pstree -np -s $fish_pid | grep -o -E '[0-9]+');
    if test -e "/run/WSL/"$i"_interop"
        export WSL_INTEROP=/run/WSL/$i"_interop"
        break
    end
end;
