# I3 LemonBar

A functional config for lemonbar to work with i3wm. 

![lemonbar full](http://i.imgur.com/9G8W9gv.png)

### Requeriments

* Of course, [lemonbar](https://github.com/LemonBoy/bar)

* Alsa-utils for volume indicator.

* Conky for CPU, MEM, NET and DISK usage.

* Curl for gmail alert.

* Weechat for private messages alert. Bitlbee for twitter and chat protocols
  integration.

* MPD and mpc for song info.

* xprop for focus app indicator.

* And finally, [i3wm](https://i3wm.org)

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
        i3bar_command ~./.i3/lemonbar/i3_lemonbar.sh
    }
    ```
* Adjust bar settings editing ***i3_lemonbar_config***. Settings for:

    * Fifo file.
    * Bar geometry.
    * Normal and icon font. [Here are my fonts used](https://github.com/electro7/dotfiles/tree/master/.fonts)
    * CPU and NET usage alerts.
    * Colors
    * Specials symbols for separator (powerline).
    * Icons glyps.

### Sections

#### Workspace

Workspace changes are received from ***i3_workspace.pl*** perl script.

![lemonbar wsp](http://i.imgur.com/Pr3AiVb.png)

#### Focus window title

Window title is received from xprop spy process.

![lemonbar title](http://i.imgur.com/strbbuz.png)

#### Time and date

Time and date is received from conky process. Conky config file is
***i3_lemonbar_conky*** and refresh meters every 2 seconds.

![lemonbar date](http://i.imgur.com/JfOINqa.png)

#### Volume

Volume is received asking amixer every 3 seconds. If is muted show a cross.

Volume channel can be set in "snd_cha" variable at config file.

![lemonbar volume](http://i.imgur.com/DqlxA4b.png)

#### Net use

ETH and WLAN use is received from conky process. If a interface is down, the
section is displayed gray with cross.

Net use alert can be set in "net_alert" var at config file (Kb).

![lemonbar net off](http://i.imgur.com/XuAzcRG.png)
![lemonbar net on](http://i.imgur.com/xBEGRla.png)

#### Disk use

Show HOME and / disk use, in %. Meter is received fron conky process.

![lemonbar disk](http://i.imgur.com/HrZcucw.png)

#### RAM and CPU use

Is received from conky process. CPU use alert can be set at "cpu_alert" var in
config file.

![lemonbar cpu off](http://i.imgur.com/cPCA1CK.png)
![lemonbar cpu on](http://i.imgur.com/QD3bBsG.png)

#### GMAIL unread message count

Is received from [gmail.sh](https://github.com/electro7/dotfiles/blob/master/bin/gmail.sh)
bash script using curl. The script is run every five minutes. Less time
can block the gmail external check.

The account user and password are read from ***~/.private/accounts***, example:

    MAIL_USER="guest"
    MAIL_PASS="1234"

![lemonbar mail off](http://i.imgur.com/yEREDl4.png)
![lemonbar mail on](http://i.imgur.com/OqLG1hO.png)

#### IRC private warning

Show a count of private messages in weechat and the last nick. 

Is received from [irc_warn.sh](https://github.com/electro7/dotfiles/blob/master/bin/irc_warn)
bash script. This script is executed by weechat every time a private message is
received.

For this, a beep trigger in weechat must be set with this:

    "/exec -bg ~/bin/irc_warn ${tg_date} ${tg_tag_nick}"

For reset the warning, run ***irc_warn*** without parameters.

![lemonbar irc off](http://i.imgur.com/TxnlC6x.png)
![lemonbar irc on](http://i.imgur.com/76mYgmf.png)

#### MPD song info

Show autor and title of current song. Use mpd and mpc.

![lemonbar mpd off](http://i.imgur.com/WQk703j.png)
![lemonbar mpd on](http://i.imgur.com/iUkqoms.png)

