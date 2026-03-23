#!/usr/bin/bash


: "${THRESHOLD:=90}"
USAGE=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')

date_time() {
    date "+%d-%m-%Y %H:%M:%S"
}


if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "$(date_time) CRITICAL: disk usage ${USAGE}%" >> "/var/log/disk.log"
    exit 2
else
    echo "$(date_time) OK: disk usage ${USAGE}%"
    exit 0
fi