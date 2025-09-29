#!/bin/bash

if ! mountpoint -q /media/root/GERSAT3/; then
    mount /media/root/GERSAT3/
fi

#xinput map-to-output 10 DP-2
#xrandr --output DP-2 --auto
#xset -dpms
#xset s noblank
#xset s off

for i in seq 15 -1 1 ; do echo -ne "Aguarde $i Segundos.\r" ; sleep 1 ; done

chmod -x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
nohup recreate-user-rabbitmq.sh &
/Zanthus/Zeus/pdvJava/pdvJava2 &
sleep 30
nohup chromium-browser --disable-gpu --disk-cache-dir=/tmp/chromium-cache --user-data-dir=$(mktemp -d) --test-type --no-sandbox --kiosk --no-context-menu --disable-translate file:////Zanthus/Zeus/Interface/index.html
