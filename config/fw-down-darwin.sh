#!/usr/bin/env bash
#
# ############################################################################
# Project: torctl (none)
# File...: config/fw-down-darwin.sh
# Created: Tuesday, 2023/01/17 - 01:44:49
# Author.: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Last Modified: Saturday, 2025/08/02 - 09:52:11
# Modified By..: @fbnmtz, (fabiano.matoz@gmail.com)
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Version: 0.0.2.7
# ~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~·~·~·~·~·~·~·~~·~·~·~·~·~~·~·~·~·~·~·~·~
# Description: 
#  >
# ############################################################################
# HISTORY:
#

# TEST: validate this rules on MacOS

fwDarwinDown(){
    local PF_RULES_BKP="$APP_HOME/pf.rules.bkp"

    if [ -f "$PF_RULES_BKP" ]; then
        # Restaura as regras do PF
        sudo pfctl -f "$PF_RULES_BKP"
        sudo pfctl -e
    else
        # Limpa todas as regras e desativa o PF
        sudo pfctl -F all
        sudo pfctl -d
    fi
}

