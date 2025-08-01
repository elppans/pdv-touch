#!/bin/bash

pdv_data="$HOME/.interface"
export pdv_data
sudo mkdir -p "$pdv_data"
sudo chmod -R 777 "$pdv_data"

chmod -x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
chmod +x /Zanthus/Zeus/pdvJava/x11vnc.sh
nohup recreate-user-rabbitmq.sh &
/Zanthus/Zeus/pdvJava/pdvJava2 &
/Zanthus/Zeus/pdvJava/x11vnc.sh &
/root/self_perto_config.sh &
/Zanthus/Zeus/pdvJava/monitor-pos-set-perto.sh | tee /tmp/monitor-pos-set-perto.log

sleep 20

nohup chromium-browser --disable-gpu \
--user-data-dir="$pdv_data" \
--no-sandbox \
--kiosk \
--no-context-menu \
--disable-translate file:////Zanthus/Zeus/Interface/index.html
#--disk-cache-dir=/tmp/chromium-cache
