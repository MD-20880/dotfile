{config, pkgs , ...} :

{
    #import configs
    environment.systemPackages = [
        #develop
        pkgs.vscode
        pkgs.git

        #media
        pkgs.ffmpeg_7-full

        #python-env
        pkgs.python3
        pkgs.pyenv

        #ruby
        pkgs.ruby

        #build
        pkgs.stdenv

        #tools
        pkgs.wget
        pkgs.htop
    ];
}