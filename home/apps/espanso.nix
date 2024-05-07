{ ... }:
{
  services.espanso = {
    enable = true;
  };
  xdg.configFile."espanso/match/base.yml".source = ./espanso/config.yml;
}
