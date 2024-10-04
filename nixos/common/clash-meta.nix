
{config, pkgs , ...} :

{
    #systemPackages
    environment.systemPackages = with pkgs; [
        clash-meta
        clash-verge
    ];

    # Prepare Clash Configuration fils here

    # TODO: Maybe it is a good idea to run it under root ?
    
    systemd.services.clash-meta = {
    description = "clash-meta";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "damien";
      Groups = "damien";
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d /home/damien/.config/mihomo";
      Restart = "always";
    };
  };

}