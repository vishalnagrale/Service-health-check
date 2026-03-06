#!/bin/bash

LOG="../logs/health.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

check_service () {
    NAME=$1
    PROCESS=$2
    START_CMD=$3

    if ! pgrep -x "$PROCESS" > /dev/null; then
        echo "$DATE | $NAME DOWN | Restarting" >> "$LOG"
        eval "$START_CMD"
    else
        echo "$DATE | $NAME RUNNING" >> "$LOG"
    fi
}

check_service "SSH" "sshd" "sudo service ssh start"
check_service "Apache" "apache2" "sudo service apache2 start"
check_service "MySQL" "mysql" "sudo service mysql start"
