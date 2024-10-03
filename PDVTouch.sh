#!/bin/bash

# Função para definir um Loop/Tempo
sleeping() {
    local time
    time="$1"
for i in $(seq "$time" -1 1); do
    echo -ne "$i Seg.\r"
    sleep 1
done
}

# Função para executar o Java (base PDVJava)
pdvjava_exec() {
# /usr/bin/unclutter 1> /dev/null &
chmod +x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
nohup dualmonitor_control-PDVJava &>>/dev/null &
# nohup igraficaJava &>>/dev/null &
nohup recreate-user-rabbitmq.sh &>>/dev/null &
echo "Iniciando pdvJava2..."
nohup xterm -e "/Zanthus/Zeus/pdvJava/pdvJava2" &>>/dev/null &
sleeping 25
}

# Função para executar o Interface
interface_exec() {
# Configuração de Profile e Storage
local temp_profile
local local_storage

temp_profile="$HOME/.interface/chromium"
local_storage="$temp_profile/Default/Local Storage"

mkdir -p "$local_storage"

echo "Iniciando interface..."
sleeping 10

# Limpar informações de profile, mas manter configuração do interface
find "$temp_profile" -mindepth 1 -not -path "$local_storage/*" -delete &>>/dev/null

# Executar Chromium com uma nova instância
setsid nohup chromium-browser --no-sandbox \
--test-type \
--no-default-browser-check \
--no-context-menu \
--disable-gpu \
--disable-session-crashed-bubble \
--disable-infobars \
--disable-background-networking \
--disable-component-extensions-with-background-pages \
--disable-features=SessionRestore \
--disable-restore-session-state \
--disable-features=DesktopPWAsAdditionalWindowingControls \
--disable-features=TabRestore \
--disable-translate \
--disk-cache-dir=/tmp/chromium-cache \
--user-data-dir="$temp_profile" \
--restore-last-session=false \
--autoplay-policy=no-user-gesture-required \
--enable-speech-synthesis \
--kiosk \
file:////Zanthus/Zeus/Interface/index.html &>>/dev/null &
}

# Execução das funções
pdvjava_exec
interface_exec

# Finalização
echo "Esta janela será fechada após..."
sleeping 55
