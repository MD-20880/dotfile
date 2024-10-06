{config, pkgs , ...} :

{
    #detect whether using gnome
    #if GNOME, install "Input Method Panel" extension
    #https://github.com/wengxt/gnome-shell-extension-kimpanel


    environment.variables = {

    };

    environment.systemPackages = with pkgs; [
        libsForQt5.fcitx5-with-addons
    ];
}