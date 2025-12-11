#!/bin/bash

MONITOR1='VGA-1'   # Nome da saída de vídeo do monitor primário conectado
MONITOR2='HDMI-1'  # Nome da saída de vídeo do monitor secundário conectado
LARG='1920'        # Largura da resolução desejada (pixels)
ALT='1080'         # Altura da resolução desejada (pixels)
FREQ='60'          # Frequência de atualização desejada (Hz)

# Mostra os monitores ativos
# O primeiro da lista (índice 0:) é considerado o monitor principal
# Os demais (1:, 2:, etc.) são secundários
# xrandr --listmonitors

# Definir manualmente o principal
# xrandr --output "$MONITOR2" --primary

# Gera um "Modeline" com base na resolução e frequência informadas e salva em /tmp/cvt_mode
cvt "$LARG" "$ALT" "$FREQ" > /tmp/cvt_mode

# Cria um novo modo de vídeo no xrandr usando o Modeline gerado
xrandr --newmode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//')

# Associa o novo modo ao monitor especificado
xrandr --addmode "$MONITOR1" $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')

# Define o monitor para usar o novo modo criado
xrandr --output "$MONITOR1" --mode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')

# Define o monitor para usar o novo modo criado, resolução e posição dos monitores
# 0x0 = Posição central no monitor 1
# "$LARG"x0 = Posicionado após a largura do monitor 1 para ficar correto no monitor 2
xrandr --output "$MONITOR1" --mode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}') --pos 0x0 \
--output "$MONITOR2" --mode "$LARG"x"$ALT" --pos "$LARG"x0


# Configura o monitor MONITOR2 para espelhar exatamente a saída do monitor MONITOR1
xrandr --output "$MONITOR2" --same-as "$MONITOR1"

# Mostra a configuração atual dos monitores conectados
xrandr | grep ' connected '

# Iniciando o PDV (Parte original do Script)
chmod -x /usr/local/bin/igraficaJava
chmod -x /usr/local/bin/dualmonitor_control-PDVJava
nohup recreate-user-rabbitmq.sh &
/Zanthus/Zeus/pdvJava/pdvJava2 &
sleep 20
chmod +x /Zanthus/Zeus/pdvJava/x11vnc.sh
/Zanthus/Zeus/pdvJava/x11vnc.sh &
nohup chromium-browser --disable-gpu --disk-cache-dir=/tmp/chromium-cache --user-data-dir=$(mktemp -d) --test-type --no-sandbox --kiosk --no-context-menu --disable-translate file:////Zanthus/Zeus/Interface/index.html

