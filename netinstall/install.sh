apt-get install -y sudo
apt-get install -y i3 rxvt-unicode-256color lightdm x11-xserver-utils
apt-get install -y git vim
apt-get install -y conky curl alsautils
apt-get install -y mpd mpc ncmpcpp
apt-get install -y notification-daemon xinput alsa-utils conky
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y 
adduser electro7
su electro7 -c "bash <(curl https://raw.githubusercontent.com/mope1/dotfiles/master/netinstall/install2.sh)"

apt-get install ruby-dev -y
gem install bropages

mkdir /tmp; cd /tmp
git clone  https://github.com/LemonBoy/bar.git
cd bar
apt-get install -y build-essential checkinstall
apt-get install -y libxcb1-dev libxcb-xinerama0-dev libxcb-randr0-dev
make install
cd ..
rm -rf bar

echo 'if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi' >> /root/.bashrc

cat /etc/lightdm/lightdm.conf | perl -pe 's/#greeter-hide-users=false/greeter-hide-users=false/' >> /tmp/lightdm.conf

mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cp -r /mnt/cdrom /root
cp /tmp/lightdm.conf /etc/lightdm/lightdm.conf
/root/cdrom/VBoxLinuxAdditions.run 

