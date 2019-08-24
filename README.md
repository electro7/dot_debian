# NOTE
This repo is out of date. I'm use only for historical reasons and one old
machine with kodi. 

At the moment i'm using archlinux in my principal desktop PC.
[here](https://github.com/electro7/dot_arch) the repo.

Thanks for the interest.

# E7 OLD dotfiles
Config files for a minimalist X desktop; i3wm & lemonbar, rxvt, bitlbee & weechat, vim, git, cnmpcpp...

### Last screenshot

Change every day. Something like this:

![last screenshot](http://i.imgur.com/tzez5a7.png)

### I3 LemonBar

![lemonbar full](http://i.imgur.com/9G8W9gv.png)

Config files and help [here](https://github.com/electro7/dotfiles/tree/master/.i3/lemonbar)

### Clean install (debian strech 9.3):

* Install debian base (without X desktop).

* Install required packages:

    ```sh
    $ apt-get install i3 rxvt-unicode-256color lightdm x11-xserver-utils
    $ apt-get install git vim
    $ apt-get install conky curl alsa-utils
    $ apt-get install mpd mpc ncmpcpp
    $ apt-get install notification-daemon xinput

    ```

* Delete all files in $HOME and clone git:

    ```sh
    $ git clone https://github.com/electro7/dotfiles.git .
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
    $ cd bar; make
    $ checkinstall -D make install
    ```

* Restart lightdm.    

