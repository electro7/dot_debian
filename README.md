# dotfiles
Config files for a minimalist X desktop; i3wm & lemonbar, rxvt, bitlbee & weechat, vim, git, cnmpcpp...

## Last screenshot

Change every day. Something like this:

![last screenshot] (https://dl.dropboxusercontent.com/u/60065791/2015-02-13-184028_1920x986_scrot.png)

## Clean install (debian jessie):

* Install debian base (without X desktop).

* Install required packages:

    ```sh
    $ apt-get install i3 rxvt-unicode-256color lightdm x11-xserver-utils
    $ apt-get install git vim
    $ apt-get install conky curl alsautils
    ```

* Delete all files in $HOME and clone git:

    ```sh
    $ git clone https://github.com/electro7/dotfiles.dot .
    ```

* Install vim plugins:

    ```sh
    $ git clone https://github.com/gmarik/Vundle.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall
    ```

* Install lemonbar:

    ```sh
    $ mkdir tmp; cd tmp
    $ git clone  https://github.com/LemonBoy/bar.git
    $ apt-get install build-essential checkinstall
    $ apt-get install libxcb1-dev libxcb-xinerama0-dev libxcb-randr0-dev
    $ make
    $ checkinstall -D make install
    ```

* Restart lightdm.    

