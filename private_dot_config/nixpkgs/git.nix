{
  programs.git = {
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
}
