
{config, pkgs , ...} :

let clash-config = pkgs.callPackage ../configs/clash-meta-config.nix {
  inherit config;
  inherit pkgs;
  subscribe_link = "https://api.dler.io/sub?target=clash&url=https%3A%2F%2Fdler.cloud%2Fsubscribe%2FKZvM7hy6oQBXDCsdlf2O%3Fclash%3Dsmart%26lv%3D2%257C3%257C4";
};
in 
{
    #systemPackages
    environment.systemPackages = [
        pkgs.clash-meta
        pkgs.clash-verge
        clash-config
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
}