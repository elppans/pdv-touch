#!/bin/bash

# 1920x1080x60
# 1440x900x60
# 1366x768x60
# 1360x768x60
# 1280x720x60
# 1280x800x60
# 1280x960x60
# 1280x1024x60

# Monitor 1 - PRIMÁRIO

MONITOR1='HDMI-1'  # Nome da saída de vídeo do monitor primário conectado
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

# Monitor 2 - SECUNDÁRIO (Descomente as linhas se quiser usar)

# MONITOR2='VGA-1'  # Nome da saída de vídeo do monitor secundário conectado
# LARG2='1920'      # Largura da resolução desejada (pixels)
# ALT2='1080'       # Altura da resolução desejada (pixels)
# FREQ2='60'        # Frequência de atualização desejada (Hz)

# cvt "$LARG2 $ALT2 $FREQ2" > /tmp/cvt_mode2
# xrandr --newmode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//')
# xrandr --addmode "$MONITOR2" $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')
# xrandr --output "$MONITOR2" --mode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')

# Configura o monitor MONITOR2 para espelhar exatamente a saída do monitor MONITOR1 (Descomentar para usar)
# xrandr --output "MONITOR2" --same-as "$MONITOR1"

######################################################################################################
# **Exemplo de sequência de comandos**                                                               #
#                                                                                                    #
# xrandr | grep " connected"                                                                         #
#                                                                                                    #
# Resposta:                                                                                          #
# eDP-1 connected primary 1366x768+0+0 (normal left inverted right x axis y axis) 344mm x 194mm      #
# HDMI-1 connected 1360x768+1366+0 (normal left inverted right x axis y axis) 410mm x 230mm          #
#                                                                                                    #
# cvt 1920 1080 60                                                                                   #
#                                                                                                    #
# Resposta:                                                                                          #
# # 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz                               #
# Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync         #
#                                                                                                    #
# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync #
# xrandr --addmode eDP-1 "1920x1080_60.00"                                                           #
# xrandr --output eDP-1 --mode "1920x1080_60.00"                                                     #
#                                                                                                    #
# xrandr --output HDMI-1 --same-as eDP-1 # Opcional, somente se quiser espelhar                      #
######################################################################################################
