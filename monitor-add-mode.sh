#!/bin/bash

# 1920x1080x60
# 1440x900x60
# 1366x768x60
# 1360x768x60
# 1280x720x60
# 1280x800x60
# 1280x960x60
# 1280x1024x60

# Monitor 1

MONITOR1='HDMI-1'  # Nome da saída de vídeo (monitor conectado via HDMI)
LARG='1920'        # Largura da resolução desejada (pixels)
ALT='1080'         # Altura da resolução desejada (pixels)
FREQ='60'          # Frequência de atualização desejada (Hz)

# Gera um "Modeline" com base na resolução e frequência informadas e salva em /tmp/cvt_mode
cvt "$LARG $ALT $FREQ" > /tmp/cvt_mode

# Cria um novo modo de vídeo no xrandr usando o Modeline gerado
xrandr --newmode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//')

# Associa o novo modo ao monitor especificado
xrandr --addmode "$MONITOR1" $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')

# Define o monitor para usar o novo modo criado
xrandr --output "$MONITOR1" --mode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')

# Monitor 2 (Descomente as linhas se quiser usar)

# MONITOR2='VGA-1'
# LARG2='1920'
# ALT2='1080'
# FREQ2='60'

# cvt "$LARG2 $ALT2 $FREQ2" > /tmp/cvt_mode2
# xrandr --newmode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//')
# xrandr --addmode "$MONITOR2" $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')
# xrandr --output "$MONITOR2" --mode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')
