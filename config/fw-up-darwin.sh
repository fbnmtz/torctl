#!/usr/bin/env bash
#
# ############################################################################
# Project: torctl (none)
# File...: config/fw-up-darwin.sh
# Created: Tuesday, 2023/01/17 - 01:29:21
# Author.: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Last Modified: Saturday, 2025/08/02 - 09:51:59
# Modified By..: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Version: 0.0.2.15
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Description: 
#  >
# ############################################################################
# HISTORY:
#

# TEST: validate this rules on MacOS

fwDarwinUp(){
    # Variáveis
    trans_port="9040"
    dns_port="5353"
    non_tor="{ 192.168.0.0/24, 192.168.1.0/24, 192.168.2.0/24, 127.0.0.0/8 }"
    tor_uid=$(docker exec -u tor torctl_server id -u)

    # Limpa regras antigas
    set skip on lo0

    # Redirecionamento de DNS para Tor
    rdr pass on en0 proto udp from any to any port 53 -> 127.0.0.1 port $dns_port

    # Redirecionamento de conexões TCP para Tor TransPort
    rdr pass on en0 proto tcp from any to any port != $trans_port -> 127.0.0.1 port $trans_port

    # Regras de filtro
    block out all
    pass out quick to $non_tor
    pass out quick proto tcp to any port $trans_port

    # # Limpa regras existentes
    # scrub-anchor "tor/*"
    # nat-anchor "tor/*"
    # rdr-anchor "tor/*"
    # anchor "tor/*"

    # # 1. Redireciona DNS para porta do Tor DNS
    # rdr pass on lo0 proto udp from any to any port 53 -> 127.0.0.1 port $dns_port

    # # 2. Redireciona todo tráfego TCP para o Tor TransPort
    # rdr pass on lo0 proto tcp from any to any port != $trans_port -> 127.0.0.1 port $trans_port

    # # 3. Permitir tráfego de rede local
    # pass out quick on en0 to $non_tor

    # # 4. Permitir tráfego do usuário do Tor
    # pass out quick on en0 user $tor_uid

    # # 5. Bloqueia todo o resto
    # block out all
}
