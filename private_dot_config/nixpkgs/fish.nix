{ pkgs, ... }:

{
  programs.fish = {
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
}
