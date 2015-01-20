#!/bin/sh
#
# Arranque de las X
# Tanto para el gestor de sessiones como para startx
#
# Para startx se usa el .xinitrc.

# Carga recursos
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources
#$HOME/bin/loadresources

# Velocidad y puntero del ratón
xset m 3

# Sonido del pitido
xset b 15 200 150

# Protector de pantalla a 60 minutos
xset s off
xset dpms 3600 3600 3600

# Mis fuentes
xset fp+ $HOME/.fonts/misc
xset fp+ $HOME/.fonts/ohsnap
xset fp+ $HOME/.fonts/terminesspowerline
# TTF se cargan automaticamente en .fonts

# Mis teclas
#xmodmap $HOME/.Xmodmap

# Gestor de ficheros
#exec rox -p default &

# Correo
#exec fetchmail &
#exec xmailbox -geometry 16x16+915+9&

# Fondo
[[ -f $HOME/.fehbg ]] && sh $HOME/.fehbg

# Programas para el i3
exec conky -c ~/.i3/conkyrc &
exec nm-applet &

# Notificador
# Paquete notification-daemon, pero hace falta el xfce4-notifid
# Probar con notify-send
exec /usr/lib/notification-daemon/notification-daemon &

# Gestor de ventanas
exec i3
