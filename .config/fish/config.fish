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

# Vi mode
fish_vi_key_bindings
set fish_cursor_replace_one underscore

# See why it makes the start freeze
# podman completion fish | source

starship init fish | source

zoxide init fish | source

# Fix for: https://github.com/microsoft/WSL/issues/5065
for i in (pstree -np -s $fish_pid | grep -o -E '[0-9]+');
    if test -e "/run/WSL/"$i"_interop"
        export WSL_INTEROP=/run/WSL/$i"_interop"
        break
    end
end;

# Adds support for !! and !$
# Suggested on https://superuser.com/questions/719531/what-is-the-equivalent-of-bashs-and-in-the-fish-shell
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

# Git abbreviations
if status --is-interactive
    abbr -a -g gco git checkout
    abbr -a -g gs git status
    abbr -a -g gc git commit
    abbr -a -g gl git log
    abbr -a -g gf git fetch
    abbr -a -g gpl git pull
    abbr -a -g gps git push
    abbr -a -g gr git rebase
    abbr -a -g gm git merge
    abbr -a -g gs git stash
end
