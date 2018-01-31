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

num_interfaces=`cat /proc/net/dev | wc -l`

for ((i=3; i<=num_interfaces; i++))
do
	intf=`cat /proc/net/dev | awk "FNR==$i" | awk '{print $1}'`
	intf_recv_bytes=`cat /proc/net/dev | awk "FNR==$i" | awk '{print $2}'`
	intf_trans_bytes=`cat /proc/net/dev | awk "FNR==$i" | awk '{print $10}'`
	
	echo -e "$intf"
	echo -e "\tBytes Received:   ${GREEN}$intf_recv_bytes${NC}"
	echo -e "\tBytes Trasmitted: ${GREEN}$intf_trans_bytes${NC}"
done

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

