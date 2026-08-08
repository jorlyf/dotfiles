{
  ...
}:
{
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "jorlyfchannel@gmail.com";
        name = "jorlyf";
      };
      core = {
        editor = "zeditor --wait";
      };
      init = {
        defaultBranch = "main";
      };
      branch.autosetupmerge = "true";
      pull.ff = "only";
      push.default = "current";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
    };
  };
}
