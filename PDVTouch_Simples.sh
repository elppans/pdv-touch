#!/bin/bash

# Espelhar = Mostrar no monitor segundário tudo que há no monitor primário
# sleep 5
# xrandr --output VGA-1 --same-as HDMI-1

# Configura o layout do teclado para brasileiro ABNT2 usando o utilitário setxkbmap
# /usr/bin/setxkbmap -layout br -variant abnt2 > /tmp/setxkbmap.log 2>&1

if ! mountpoint -q /media/root/GERSAT3/; then
    mount /media/root/GERSAT3/
fi

pdv_data="$HOME/.interface"
export pdv_data
sudo mkdir -p "$pdv_data"
sudo chmod -R 777 "$pdv_data"

chmod -x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
nohup recreate-user-rabbitmq.sh &
xterm -e /Zanthus/Zeus/pdvJava/pdvJava2 &

clear
for i in `seq 30 -1 1` ; do echo -ne "Aguarde $i Segundos.\r" ; sleep 1 ; done

nohup chromium-browser --disable-gpu \
--disk-cache-dir=/tmp/chromium-cache \
--user-data-dir="$pdv_data" \
--test-type \
--no-sandbox \
--kiosk \
--no-context-menu \
--disable-translate file:////Zanthus/Zeus/Interface/index.html
#--user-data-dir=$(mktemp -d) \
