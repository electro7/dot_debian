apt-get install -y sudo
apt-get install -y i3 rxvt-unicode-256color lightdm x11-xserver-utils
apt-get install -y git vim
apt-get install -y conky curl alsautils
apt-get install -y mpd mpc ncmpcpp
apt-get install -y notification-daemon xinput alsa-utils
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y 
adduser electro7
su electro7 -c "bash <(curl https://raw.githubusercontent.com/mope1/dotfiles/master/netinstall/install2.sh)"

mkdir /tmp; cd /tmp
git clone  https://github.com/LemonBoy/bar.git
cd bar
apt-get install -y build-essential checkinstall
apt-get install -y libxcb1-dev libxcb-xinerama0-dev libxcb-randr0-dev
make install
cd ..
rm -rf bar
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cp -r /mnt/cdrom /root
/root/cdrom/VBoxLinuxAdditions.run 

