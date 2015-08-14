# I3 LemonBar

A functional config for lemonbar to work with i3wm. 

### Requeriments

* Of course, [lemonbar] (https://github.com/LemonBoy/bar)

* Alsautils for volume indicator.

* Conky for CPU, MEM, NET and DISK usage.

* Curl for gmail alert.

* Weechat for private messages alert. Bitlbee for twitter and chat protocols
  integration.

* MPD and ncmpcpp for song info.

* xprop for focus app indicator.

* And finally, [i3wm] (https://i3wm.org)

### Basically, how it works?

***i3_lemonbar.sh*** bash script read the configuration from
***i3_lemonbar_config*** file. 

Later, execute the requested apps for the diferent meter sections. The output
is redirected to fifo file, adding 3 letters ID for each.

Finally, run a ***i3_lemonbar_parser.sh*** that read from fifo, check the ID
meter, and converts it with lemonbar format.

### Configuration

* Change the bar section on i3wm config:

    ```
    bar {
        i3_bar_command ~./.i3/lemonbar/i3_lemonbar.sh
    }
    ```
* Adjust bar settings editing i3_lemonnar_config. Settings for:

    * Fifo file.
    * Bar geometry.
    * Normal and icon font. [My fonts] (https://github.com/electro7/dotfiles/tree/master/.fonts)
    * CPU and NET usage alerts.
    * Colors
    * Specials symbols for separator (powerline).
    * Icons glyps.

    > Two fonts are needed. A font for normal text and separator symbols, and
    > another for icons.
    > [Here ara my fonts] (https://github.com/electro7/dotfiles/tree/master/.fonts)

### Sections

#### Workspace

Workspace changes are received from ***i3_workspace.pl*** perl script.

#### Focus window title

Window title is received from xprop spy process.

#### Time and date

Time and date is received from conky process. Conky config file is
***i3_lemonbar_conky*** and refresh meters every 2 seconds.

#### Volume

Volume is received asking amixer every 3 seconds. If is muted show a cross.

Volume channel can be set in "snd_cha" variable at config file.

#### Net use

ETH and WLAN use is received from conky process. If a interface is down, the
section is displayed gray with cross.

Net use alert can be set in "net_alert" var at config file (Kb).

#### Disk use

Show HOME and / disk use, in %. Meter is received fron conky process.

#### RAM and CPU use

Is received from conky process. CPU use alert can be set at "cpu_alert" var in
config file.

#### GMAIL unread message count

Is received from [gmail.sh] (https://github.com/electro7/dotfiles/blob/master/bin/gmail.sh)
bash script using curl. The script is run every five minutes. Less time
can block the gmail external check.

The account user and password are read from ***~/.private/accounts***, example:

    ```
    MAIL_USER="guest"
    MAL_PASS="1234"
    ```

#### IRC private warning

Show a count of private messages in weechat and the last nick. 

Is received from [irc_warn.sh] (https://github.com/electro7/dotfiles/blob/master/bin/irc_warn)
bash script. This script is executed by weechat every time a private message is
received.

For this, a beep trigger in weechat must be set with this:

    ```
    "/exec -bg ~/bin/irc_warn ${tg_date} ${tg_tag_nick}"
    ```

For reset the warning, run ***irc_warn*** without parameters.

#### MPD song info

Show autor and title of current song. Use mpd and ncmpcpp.










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

