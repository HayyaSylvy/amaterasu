{

  # Simple module so my git commits register as coming from my Github user.
  programs.git = {
     enable = true;
     settings = {
       user.name = "HayyaSylvy";
       user.email = "hannahmarieribeiro@proton.me";
     };
  };
  # Enables Github login with GH, can't declare my Github login and passowrd for obvious reasons :P
  # Login with "gh auth login" (PS: not sure :P)
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

}
