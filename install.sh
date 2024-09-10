
pacman-s := '' 
yay-s := ''

#locale Settings

#install ohmysh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#hyprland installation

sudo pacman -Syu hyprland
##Some Hyprland Settings For NVIDIA Driver(Though i may not need it) 


#Audio Stuff

#yay installation
yay-s += feeluown feeluown-netease

#software installation

#install with pacman

#Setup Current Time to Shanghai
timedatectl set-timezone Asia/Shanghai


#font installation


pacman-s += zoxide
pacman-s += unzip 
