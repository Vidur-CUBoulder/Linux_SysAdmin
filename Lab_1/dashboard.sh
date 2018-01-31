#!/bin/bash

#Optional Color Coded Outputs
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
NC="\033[0m"

echo -e "------${BLUE}CPU and Memory Resources${NC}------"

cpu_load=`uptime | tail -c 17`
echo -e "CPU Average Load: ${GREEN}$cpu_load${NC}"

free_RAM=`free -h | awk '{print $3}' | awk 'FNR==2'`
echo -e "Free RAM: ${GREEN}$free_RAM${NC}"

echo -e "\n"
echo -e "------${BLUE}Network Connections${NC}------"

intf_1=`cat /proc/net/dev | awk 'FNR==3' | awk '{print $1}'`
intf_1_recv_bytes=`cat /proc/net/dev | awk 'FNR==3' | awk '{print $2}'`
intf_1_trans_bytes=`cat /proc/net/dev | awk 'FNR==3' | awk '{print $10}'`

intf_2=`cat /proc/net/dev | awk 'FNR==4' | awk '{print $1}'`
intf_2_recv_bytes=`cat /proc/net/dev | awk 'FNR==4' | awk '{print $2}'`
intf_2_trans_bytes=`cat /proc/net/dev | awk 'FNR==4' | awk '{print $10}'`

num_interfaces=`cat /proc/net/dev | wc -l`

echo -e "$intf_1"
echo -e "\tBytes Received:   ${GREEN}$intf_1_recv_bytes${NC}"
echo -e "\tBytes Trasmitted: ${GREEN}$intf_1_trans_bytes${NC}"

echo -e "$intf_2"
echo -e "\tBytes Received:   ${GREEN}$intf_2_recv_bytes${NC}"
echo -e "\tBytes Trasmitted: ${GREEN}$intf_2_trans_bytes${NC}"

echo -e "\n"

#Ping google once and check for success or failure
if `ping -q -c 1 -W 1 www.google.com > /dev/null`;
then
  echo -e "Internet Connectivity: ${GREEN}Yes${NC}"
else
  echo -e "Internet Connectivity: ${RED}No${NC}"
fi

echo -e "\n"
echo -e "------${BLUE}Account Information${NC}------"

total_users=`cat /etc/passwd | wc -l`
active_users=`who | wc -l`

echo -e "Total Users: ${GREEN}$total_users${NC} \t Number Active: ${GREEN}$active_users${NC}"
echo -e "Shells:"
echo -e "\t/sbin/nologin: ${GREEN}`cat /etc/passwd | grep "/sbin/nologin" | wc -l`${NC}"
echo -e "\t/bin/bash:     ${GREEN}`cat /etc/passwd | grep "/bin/bash" | wc -l`${NC}"
echo -e "\t/bin/false:    ${GREEN}`cat /etc/passwd | grep "/bin/false" | wc -l`${NC}"

echo -e "\n"

echo -e "------${BLUE}Filesystem Information${NC}------"
echo -e "Total Number of Files:       ${GREEN}`find / -type f | wc -l`${NC}"
echo -e "Total Number of Directories: ${GREEN}`find / -type d | wc -l`${NC}"

