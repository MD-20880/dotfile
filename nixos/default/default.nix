{config, pkgs , ...} :

let clash-config = pkgs.callPackage ../configs/clash-meta-config.nix {
  inherit config;
  inherit pkgs;
  subscribe_link = "https://api.dler.io/sub?target=clash&url=https%3A%2F%2Fdler.cloud%2Fsubscribe%2FKZvM7hy6oQBXDCsdlf2O%3Fclash%3Dsmart%26lv%3D2%257C3%257C4";
  geoip_link = "https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/Country.mmdb";
};
in 
{
    #import configs
    environment.systemPackages = [
        #mail
        pkgs.thunderbird


        #neofetch
        pkgs.neofetch

        #Clash
        pkgs.clash-meta
        pkgs.clash-verge
        clash-config

        #vim
        pkgs.vim
	pkgs.neovim

        #media
        pkgs.vlc

        #office
        pkgs.libreoffice-qt6-fresh

        #communication
        pkgs.discord
        pkgs.telegram-desktop

        #RSS
        pkgs.libsForQt5.akregator

        #torrent
        pkgs.qbittorrent-qt5

        #oh-my-zsh
        # pkgs.oh-my-zsh

        #PDF VIEWER

        #Fun things
        pkgs.gnuradio

        #password manager
        pkgs.enpass

        #tools
        pkgs.localsend
        pkgs.ncdu

        #games
        pkgs.steam
        pkgs.docker
        pkgs.docker-compose
        
    ];

    # Prepare Clash Configuration fils under root file
    systemd.services.clash-meta = {
    description = "clash-meta";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "root";
      Groups = "root";
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d ${clash-config}/.config/mihomo/";
      Restart = "always";
    };
  };
    
    systemd.services.docker = {
      description = "dockerd";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = "${pkgs.docker}/bin/dockerd";
        Restart = "always";
        LimitNOFILE=1048576;
      };
    };

  i18n.inputMethod={
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-nord
    ];
  };
}
