#!/bin/bash
# Test script for Vimux functionality
# This script contains various Linux commands and code snippets
# to test the Vimux key mappings and functions

# =============================================================================
# SYSTEM INFORMATION COMMANDS
# =============================================================================
# Display hostname
hostname

# Show current date and time
date

# Display calendar for current month
cal

# Show system uptime
uptime

# Display current user
whoami

# Show current working directory
pwd

# =============================================================================
# NETWORK INFORMATION
# =============================================================================
# Show IP addresses (try both commands)
ip addr show
ifconfig

# Display network connections
netstat -tuln

# Show routing table
ip route

# =============================================================================
# SYSTEM MONITORING
# =============================================================================
# Display disk usage
df -h

# Show memory usage
free -h

# List running processes
ps aux | head -10

# Show system load
cat /proc/loadavg

# =============================================================================
# FILE OPERATIONS
# =============================================================================
# List files in current directory
ls -la

# Show file count in current directory
ls -1 | wc -l

# Display file types
file /etc/passwd /bin/bash

# =============================================================================
# CONDITIONAL STATEMENTS (IF)
# =============================================================================
# Check if file exists
if [ -f "/etc/passwd" ]; then
    echo "Password file exists"
else
    echo "Password file not found"
fi

# Check system load
if [ $(cat /proc/loadavg | cut -d' ' -f1 | cut -d'.' -f1) -gt 1 ]; then
    echo "High system load detected"
else
    echo "System load is normal"
fi

# Check available disk space
if [ $(df / | tail -1 | awk '{print $5}' | sed 's/%//') -gt 80 ]; then
    echo "Disk space is running low"
else
    echo "Disk space is adequate"
fi

# =============================================================================
# LOOPS (FOR)
# =============================================================================
# Count from 1 to 5
for i in {1..5}; do
    echo "Count: $i"
done

# List files in /etc that start with 'h'
for file in /etc/h*; do
    if [ -f "$file" ]; then
        echo "Found file: $file"
    fi
done

# Check multiple directories
for dir in /home /tmp /var; do
    echo "Directory: $dir - $(ls $dir | wc -l) items"
done

# Process multiple users
for user in root daemon bin; do
    if id "$user" >/dev/null 2>&1; then
        echo "User $user exists"
    else
        echo "User $user does not exist"
    fi
done

# =============================================================================
# COMBINED COMMANDS (PIPES AND CHAINS)
# =============================================================================
# Show top 5 largest files in /var/log
ls -la /var/log | sort -k5 -nr | head -5

# Count number of users in system
cat /etc/passwd | wc -l

# Show processes using most CPU
ps aux | sort -k3 -nr | head -5

# Display system information summary
echo "=== SYSTEM SUMMARY ==="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "Uptime: $(uptime | cut -d',' -f1)"
echo "Load: $(cat /proc/loadavg | cut -d' ' -f1-3)"
echo "Memory: $(free -h | grep Mem | awk '{print $3"/"$2}')"
echo "Disk: $(df -h / | tail -1 | awk '{print $3"/"$2" ("$5" used)"}')"

# =============================================================================
# SERVICE AND PROCESS MANAGEMENT
# =============================================================================
# Check if systemd is running
systemctl is-active systemd-logind

# Show failed services
systemctl --failed

# Display system services status
systemctl list-units --type=service --state=running | head -10

# =============================================================================
# LOG MONITORING COMMANDS
# =============================================================================
# Show last 10 lines of system log
tail -10 /var/log/messages 2>/dev/null || tail -10 /var/log/syslog 2>/dev/null || echo "No system log found"

# Display recent login attempts
last | head -5

# Show kernel messages
dmesg | tail -10
