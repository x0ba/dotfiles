{
  imports = [ ./brew.nix ];

  nix.settings.extra-platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  location = {
    latitude = 37.430759;
    longitude = -121.897507;
  };
}
