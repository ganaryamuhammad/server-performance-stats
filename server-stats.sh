#!/bin/bash

echo "===== SERVER PERFORMANCE STATS ====="
echo ""

# CPU Usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"% used"}'
echo ""

# Memory Usage
echo "Memory Usage:"
free -m | awk 'NR==2{
used=$3;
free=$4;
total=$2;
printf "Used: %s MB / Free: %s MB / Total: %s MB (%.2f%% used)\n", used, free, total, used*100/total
}'
echo ""

# Disk Usage
echo "Disk Usage:"
df -h / | awk 'NR==2{
printf "Used: %s / Free: %s / Total: %s (%s used)\n", $3, $4, $2, $5
}'
echo ""

# Top 5 CPU Process
echo "Top 5 Processes by CPU:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 Memory Process
echo "Top 5 Processes by Memory:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo ""
