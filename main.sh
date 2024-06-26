#!/bin/bash

cd "$(dirname "$0")"
source settings.txt
machine=$(hostname)
TEMP_FILE="mailbody.tmp"

send_mail() {
    mail -s "$machine Ressources Alert" $email < $TEMP_FILE
}

check_cup() {
    cpu_load=$(top -bn1 | grep "Cpu" | awk '{print $2 + $4 + $6}')
    if (( $(echo "$cpu_load > $cpu_threshold" | bc)  )); then
        echo "cpu load ($cpu_load%) is higher than cpu threshold" >> $TEMP_FILE
    fi
}

check_ram() {
    ram_load=$(free  | grep Mem | awk '{print ($3*100.0)/$2}')
    if (( $(echo "$ram_load > $ram_threshold" | bc)  )); then
        echo "ram load ($ram_load%) is higher than ram threshold " >> $TEMP_FILE
    fi
}

check_disk() {
    disk_load=$(df -h / | grep / | awk '{ print $5}' | sed 's/%//')
    if (( $(echo "$disk_load > $disk_threshold" | bc)  )); then
        echo "disk load  ($disk_load%) is higher than disk usage threshold " >> $TEMP_FILE
    fi
}

main() {
    > $TEMP_FILE

    check_cup
    check_ram
    check_disk

    if [ -s $TEMP_FILE ]; then
        send_mail
    fi
    rm -f $TEMP_FILE

}

main