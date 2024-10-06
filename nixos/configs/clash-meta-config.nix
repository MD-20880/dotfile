{ 
    pkgs, 
    config, 
    subscribe_link ? "", 
    geoip_link ? "https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/Country.mmdb", ... }:

pkgs.stdenv.mkDerivation {
  pname = "clash-meta-config";
  version = "1.0";

#   从服务器下载 Clash 配置文件
  src = builtins.fetchurl {
    url = "${subscribe_link}";
    name = "config.yaml";
  };

  geoip = builtins.fetchurl {
    url = "${geoip_link}";
    name = "geoip.metadb";
  };

  unpackPhase = '' 
    # 跳过解压过程
    echo "No source to unpack"
  '';

  installPhase = ''
    mkdir -p $out/.config/mihomo
    cp $src $out/.config/mihomo/config.yaml  # 将下载的配置文件复制到user .config directory
    cp $geoip $out/.config/mihomo/geoip.metadb
    # 
  '';

  meta = {
    description = "clash-meta-configs";
    license = pkgs.lib.licenses.mit; # 修改为合适的许可证
  };
}
