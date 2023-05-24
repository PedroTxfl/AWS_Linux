#!/bin/bash

# Diretório de saída
dir_de_saida="/mnt/nfs/pedro"

# Função para verificar o status do Apache e registrar o resultado
validador_apache() {
    apache_status=$(systemctl is-active httpd)

    if [[ $apache_status == "active" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Apache Online - O Apache está em execução." >> "$dir_de_saida/apache_online.txt"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') Apache Offline - O Apache não está em execução." >> "$dir_de_saida/apache_offline.txt"
    fi
}

# Executa a função 
validador_apache

