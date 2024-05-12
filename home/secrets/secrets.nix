let
  homes = {
    fermata = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+Jn09z0d1pJZ34LfC/s5B4PF6Ohy76rZyKV5PDpkSv";
  };
  yubikeys = {
    _5c1 = "age1yubikey1qtl2qmcpwsuse7va9834n2uucyynjyvguzycwgwtfz7h0mjnf2fgypkdw6g";
    _5c2 = "age1yubikey1qdqr74wn9tar9ep9vw5seuv5cy7pk2vkgff7h90tvcec3gsd43lc7udx52v";
  };

  default = [
    yubikeys._5c1
    yubikeys._5c2
  ] ++ (builtins.attrValues homes);
in
{
  "home/secrets/wakatime.cfg.age".publicKeys = default;
}
