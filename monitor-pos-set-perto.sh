#!/bin/bash

# Variáveis para configuração da janela a posicionar

aplicacao="IP Camera Stream"
# Variáveis para configuração de monitores
monitor1='HDMI-2'
monitor2='HDMI-1'
resolucao1='1024x768'
resolucao2='1920x1080'

# Variáveis para posição dos aplicativos para cada tela
# VARIAVEIS NÃO EDITAVEIS, FUNCIONALIDADE AUTOMATICA
posicao1='0x0' # Posicao Horizontal x Vertical, 1º monitor

# Extrair a largura do primeiro monitor
largura_monitor1=$(echo "$resolucao1" | cut -dx -f1)

# Construir a nova posição para o segundo monitor
nova_posicao2="${largura_monitor1}x0"

# Substituir a variável posicao2
# posicao2='1024x0' # Posição após o valor "Horizontal" do 1º monitor. 2º monitor
posicao2="$nova_posicao2" # Posição do 2º monitor, automatico

# Substitui 'x' por ','
posicaox1="$(echo $posicao1 | sed 's/x/,/')"
posicaox2="$(echo $posicao2 | sed 's/x/,/')"

# Exportando todas as variáveis
export monitor1
export monitor2
export resolucao1
export resolucao2
export posicao1
export posicao2
export posicaox1
export posicaox2

echo "monitor1: $monitor1"
echo "monitor2: $monitor2"
echo "resolucao1: $resolucao1"
echo "resolucao2: $resolucao2"
echo "posicao1: $posicao1"
echo "posicao2: $posicao1"
echo "posicaox1: $posicaox1"
echo "posicaox2: $posicaox2"

# Configura a resolução e posição dos monitores
xrandr --output "$monitor1" --mode "$resolucao1" --pos "$posicao1" --output "$monitor2" --mode "$resolucao2" --pos "$posicao2"

# Sair para teste, ver se a resolução funciona:
# exit

# Função para definir um Loop/Tempo
sleeping() {
  local time
  time="$1"
  for i in $(seq "$time" -1 1); do
    echo -ne "$i Seg.\r"
    sleep 1
  done
}

monitor_param() {
  while true; do
    WMID=$(wmctrl -l | grep "$aplicacao" | cut -d " " -f1)
    if [ -z "$WMID" ]; then
      echo -e "Aguardando \"$aplicacao\" iniciar..."
      sleeping 5
      clear
    else
      # Garantir que o Java seja configurado na posição parametrizada.
      # wmctrl -i -r $WMID -e "0,$posicaox1,-1,-1"
      # posicaox1 = Monitor 1, posicaox2 = Monitor 2
      echo -e "wmctrl -i -r $WMID -e \"0,$posicaox2,-1,-1\"" # Debug de como ficará o comando
      wmctrl -i -r $WMID -e "0,$posicaox2,-1,-1"
      echo -e "Janela \"$aplicacao\" encontrada e configurada."
      break
    fi
  done
}

monitor_param


