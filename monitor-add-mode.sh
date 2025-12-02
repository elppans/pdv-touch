#!/bin/bash

# 1920x1080x60
# 1366x768x60
# 1280x720x60

# Monitor 1

MONITOR1='HDMI-1'
LARG='1920'
ALT='1080'
FREQ='60'

cvt "$LARG $ALT $FREQ" > /tmp/cvt_mode
xrandr --newmode $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//')
xrandr --addmode "$MONITOR1" $(grep 'Modeline' /tmp/cvt_mode | sed 's/Modeline//' | awk '{print $1}')
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
