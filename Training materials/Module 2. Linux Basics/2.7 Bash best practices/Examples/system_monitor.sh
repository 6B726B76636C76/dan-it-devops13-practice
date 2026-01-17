#!/bin/bash

# System Monitoring Script

# Check CPU usage
cpu_usage=$(top -bn 1 | awk 'NR>7{s+=$9}END{print s}')
echo "CPU Usage: ${cpu_usage}%"

# Check memory usage
memory_usage=$(free | awk '/Mem/{printf("%.2f", ($3/$2)*100)}')
echo "Memory Usage: ${memory_usage}%"

# Check disk usage
disk_usage=$(df -h / | awk '/\//{print $5}')
echo "Disk Usage: ${disk_usage}"

# Check network connectivity
ping -c 3 google.com > /dev/null
if [ $? -eq 0 ]; then
  echo "Network Connectivity: Connected"
else
  echo "Network Connectivity: Disconnected"
fi

