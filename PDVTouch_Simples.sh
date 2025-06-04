#!/bin/bash

pdv_data="$HOME/.interface"
export pdv_data
sudo mkdir -p "$pdv_data"
sudo chmod -R 777 "$pdv_data"

chmod -x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
nohup recreate-user-rabbitmq.sh &
xterm -e /Zanthus/Zeus/pdvJava/pdvJava2 &

clear
for i in seq 30 -1 1 ; do echo -ne "Aguarde $i Segundos.\r" ; sleep 1 ; done

nohup chromium-browser --disable-gpu \
--user-data-dir="$pdv_data" \
--no-sandbox \
--kiosk \
--no-context-menu \
--disable-pinch --disable-gpu --test-type --incognito \
--disable-translate file:////Zanthus/Zeus/Interface/index.html
#--disk-cache-dir=/tmp/chromium-cache
