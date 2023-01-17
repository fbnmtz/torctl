#!/usr/bin/env bash
#
# ############################################################################
# Project: torctl (none)
# File...: config/fw-up-linux.sh
# Created: Tuesday, 2023/01/17 - 01:28:44
# Author.: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Last Modified: Tuesday, 2023/01/17 - 01:53:12
# Modified By..: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Version: 0.0.1.5
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Description: 
#  >
# ############################################################################
# HISTORY:
#

fwLinuxUp(){
    iptables-save > $APP_HOME/iptables.rules.bkp

    ### set vars
    _tor_uid=$(docker exec -u tor torctl_server id -u)
    _non_tor="192.168.0.0/24 192.168.1.0/24 192.168.2.0/24"
    _trans_port="9040"
    _dns_port="5353"

    ### set iptables *nat
    iptables -t nat -A OUTPUT -m owner --uid-owner $_tor_uid -j RETURN
    iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports $_dns_port

    # allow clearnet access for hosts in $_non_tor
    for _clearnet in $_non_tor 127.0.0.0/9 127.128.0.0/10; do
        iptables -t nat -A OUTPUT -d $_clearnet -j RETURN
    done

    # redirect all other output to Tor's TransPort
    iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $_trans_port
    # iptables -t nat -A OUTPUT -p upd --syn -j REDIRECT --to-ports $_trans_port

    ### set iptables *filter
    iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

    # allow clearnet access for hosts in $_non_tor
    for _clearnet in $_non_tor 127.0.0.0/8; do
        iptables -A OUTPUT -d $_clearnet -j ACCEPT
    done

    # allow only Tor output
    iptables -A OUTPUT -m owner --uid-owner $_tor_uid -j ACCEPT
    iptables -A OUTPUT -j REJECT
}