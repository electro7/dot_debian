#basics
apt-get update
apt-get install -y sudo git

#compile a custom vim
apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev git

apt-get remove -y vim vim-runtime gvim
apt-get remove -y vim-tiny vim-common vim-gui-common

mkdir /opt
cd /opt
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
make install

#x
apt-get install -y i3 rxvt-unicode-256color lightdm x11-xserver-utils

#sound stuff
apt-get install -y alsautils
apt-get install -y mpd mpc ncmpcpp
apt-get install -y notification-daemon xinput alsa-utils conky

#user home directory setup
adduser electro7
apt-get install -y curl
su electro7 -c "bash <(curl https://raw.githubusercontent.com/mope1/dotfiles/master/netinstall/install2.sh)"

#bropages
apt-get install -y ruby-dev ruby
gem install bropages

#browsing
apt-get install -y iceweasel icedove keepass2 links

#lemonbar
mkdir /tmp; cd /tmp
git clone  https://github.com/LemonBoy/bar.git
cd bar
apt-get install -y build-essential checkinstall
apt-get install -y libxcb1-dev libxcb-xinerama0-dev libxcb-randr0-dev
make install
cd ..
rm -rf bar

#autocompletion for root
#TODO replace this with a bashrc that gets copied
echo 'if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi' >> /root/.bashrc


#autologin
cat /etc/lightdm/lightdm.conf | perl -pe 's/#greeter-hide-users=false/greeter-hide-users=false/' >> /tmp/lightdm.conf

#allow sudo
echo 'electro7	ALL=(ALL:ALL) ALL' >> /etc/sudoers

#update system
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y 

#vbox quest additions
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
cp -r /mnt/cdrom /root
cp /tmp/lightdm.conf /etc/lightdm/lightdm.conf
/root/cdrom/VBoxLinuxAdditions.run 
