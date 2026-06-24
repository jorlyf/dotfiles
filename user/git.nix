{
  config,
  ...
}:
{
  programs.git = {
    enable = true;
  };

  system.activationScripts.createUserGitconfig = {
    text = ''
      touch ${config.users.users.jorlyf.home}/.gitconfig

      cat > ${config.users.users.jorlyf.home}/.gitconfig << EOF
      [user]
        name = jorlyf
        email = jorlyfchannel@gmail.com
      [core]
        editor = nano
      EOF

      chown ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.gitconfig
      chmod 644 ${config.users.users.jorlyf.home}/.gitconfig
    '';
  };
}
