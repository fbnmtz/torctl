#!/usr/bin/env bash
#
# ############################################################################
# Project: torctl (none)
# File...: config/fw-down-linux.sh
# Created: Tuesday, 2023/01/17 - 01:45:02
# Author.: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Last Modified: Tuesday, 2023/01/17 - 23:07:14
# Modified By..: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Version: 0.0.1.4
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Description: 
#  >
# ############################################################################
# HISTORY:
#

fwLinuxDown(){
    if [ -f $APP_HOME/iptables.rules.bkp ]; then
        iptables-restore $APP_HOME/iptables.rules.bkp
    else
        # clear all FW rules
        iptables -P INPUT ACCEPT && \
        iptables -P FORWARD ACCEPT && \
        iptables -P OUTPUT ACCEPT && \
        iptables -t nat -F && \
        iptables -t mangle -F && \
        iptables -F && \
        iptables -X
    fi
}