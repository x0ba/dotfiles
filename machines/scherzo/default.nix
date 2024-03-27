{
  imports = [../common/wsl];

  i18n.defaultLocale = "en_US.UTF-8";
  location = {
    latitude = 37.430759;
    longitude = -121.897507;
  };
  time.timeZone = "America/Los_Angeles";

  wsl = {
    enable = true;
    defaultUser = "daniel";
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };
}
