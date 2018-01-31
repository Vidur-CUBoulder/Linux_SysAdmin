#!/bin/bash

##############################################################################
############################## PLEASE NOTE ###################################
## The following script can be run periodically by adding the following ######
## line to the cron script using $crontab -e or specifically modifying the ###
## cron script at /var/spool/cron/root. Below is an example of what is added #
## to the cron on my local system:
##	*/2 * * * * source /root/Linux_SysAdmin/Lab_1/monitor_usage.sh    ####
## The above line will run the script every 2 minutes 			######
##############################################################################
# 1. Bash script to monitor the / and /boot directories
# 2. Send a mail to the admin if Use% is greater than the threshold supplied 
#    by the user from the command line.

#Store the parsed percentage values in the below variables
monitor_root=`df -ah / | awk '{print $5}' | cut -d \% -f 1 | awk 'FNR==2'`
monitor_boot=`df -ah /boot/ | awk '{print $5}' | cut -d \% -f 1 | awk 'FNR==2'`

#Hold the threshold and email values in the below variables 
THRESHOLD=10
EMAIL="root@localhost"

#Check if the value entered for percentage is > 100
if [ $THRESHOLD -gt 100 ]
then
	echo "Please enter a value lesser than 100"
	exit 1
fi

#Send the mail if either value is greater than the entered threshold
if [ $monitor_boot -gt $THRESHOLD ]
then
	#Send the mail
	mail -s "FILESYSTEM THRESHOLD CROSSED!!" $EMAIL <<< "The Use% for /boot ($monitor_boot) has been exceeded!" 
fi

if [ $monitor_root -gt $THRESHOLD ]
then
	#Send the mail
	mail -s "FILESYSTEM THRESHOLD CROSSED!!" $EMAIL <<< "The Use% for / ($monitor_root) has been exceeded!" 
fi
